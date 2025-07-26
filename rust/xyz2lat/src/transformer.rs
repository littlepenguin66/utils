// src/transformer.rs

use crate::cli::{FileArgs, SingleArgs};
use crate::error::AppError;
use crate::texts::Texts;
use csv::{ReaderBuilder, StringRecord, Writer};
use proj::Proj;
use log::{warn, error};

/// 处理单个坐标点的转换
///
/// # 参数
/// - `args`: 包含源CRS、目标CRS和待转换坐标的参数
/// - `texts`: 当前语言的文本集合
///
/// # 返回值
/// 成功时返回 `Ok(())`，失败则返回 `Err(AppError)`
pub fn transform_single(args: &SingleArgs, texts: &Texts) -> Result<(), AppError> {
    // 现在 '?' 可以正确转换 ProjCreateError
    let proj = Proj::new_known_crs(&args.source_crs, &args.target_crs, None)?;

    let point = (args.coords[0], args.coords[1]);
    // '?' 也可以正确转换 ProjError
    let result = proj.convert(point)?;

    println!("{}: {:.6}, {:.6}", texts.transform_result, result.0, result.1);
    Ok(())
}

/// 处理文件批量转换
///
/// # 参数
/// - `args`: 包含源CRS、目标CRS、输入文件和输出文件路径的参数
/// - `texts`: 当前语言的文本集合
///
/// # 返回值
/// 成功时返回 `Ok(())`，失败则返回 `Err(AppError)`
pub fn transform_file(args: &FileArgs, texts: &Texts) -> Result<(), AppError> {
    // 现在 '?' 可以正确转换 ProjCreateError
    let proj = Proj::new_known_crs(&args.source_crs, &args.target_crs, None)?;

    // 简化: 移除 map_err，直接使用 '?'，让 From<csv::Error> 处理
    let mut reader = ReaderBuilder::new()
        .has_headers(true)
        .from_path(&args.input_file)?;

    // 简化: 移除 map_err，直接使用 '?'
    let mut writer = Writer::from_path(&args.output_file)?;

    // 写入新的表头
    let mut headers = reader.headers()?.clone();
    headers.push_field("transformed_x");
    headers.push_field("transformed_y");
    writer.write_record(&headers)?;

    let mut record = StringRecord::new();
    while reader.read_record(&mut record)? {
        if record.len() < 2 {
            let line = record.position().map(|p| p.line()).unwrap_or(0);
            warn!(
                "{} (line {}): {:?}. {}: {}",
                texts.warning_skip_row,
                line,
                &record,
                texts.reason,
                "Row has fewer than 2 columns"
            );
            continue;
        }

        let parse_coord = |val: &str, field_index: usize| -> Result<f64, ()> {
            val.trim().parse().map_err(|_| {
                let line = record.position().map(|p| p.line()).unwrap_or(0);
                warn!(
                    "{} (line {}): field[{}]='{}'. {}: {}",
                    texts.warning_skip_row,
                    line,
                    field_index,
                    val,
                    texts.reason,
                    texts.error_invalid_coordinate
                );
            })
        };

        let x = match parse_coord(&record[0], 0) {
            Ok(v) => v,
            Err(_) => continue,
        };
        let y = match parse_coord(&record[1], 1) {
            Ok(v) => v,
            Err(_) => continue,
        };

        match proj.convert((x, y)) {
            Ok(transformed_coords) => {
                record.push_field(&transformed_coords.0.to_string());
                record.push_field(&transformed_coords.1.to_string());
                writer.write_record(&record)?;
            }
            Err(e) => {
                let line = record.position().map(|p| p.line()).unwrap_or(0);
                error!(
                    "{} (line {}): ({}, {}). {}: {}",
                    texts.warning_skip_row,
                    line,
                    x,
                    y,
                    texts.reason,
                    e
                );
            }
        }
    }

    // 现在 '?' 可以正确转换 std::io::Error
    writer.flush()?;
    println!("{} {}", texts.file_transform_complete, &args.output_file);
    Ok(())
}
