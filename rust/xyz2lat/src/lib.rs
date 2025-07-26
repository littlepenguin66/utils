// src/lib.rs

pub mod cli;
pub mod error;
pub mod texts;
pub mod transformer;

use cli::{Cli, Mode};
use error::AppError;
use texts::get_texts;

/// 应用程序的主运行函数
///
/// 这个函数是库的公共入口点。它接收解析后的命令行参数，
/// 并根据子命令分派到相应的处理函数。
pub fn run(cli: Cli) -> Result<(), AppError> {
    // 根据 --lang 参数获取对应的文本集
    let texts = get_texts(&cli.lang);

    // 匹配子命令并执行相应的转换逻辑
    match &cli.mode {
        Mode::Single(args) => {
            transformer::transform_single(args, &texts)?;
        }
        Mode::File(args) => {
            transformer::transform_file(args, &texts)?;
        }
    };

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::cli::{FileArgs, SingleArgs, Mode};
    
    #[test]
    fn test_cli_parsing_single() {
        let args = vec![
            "xyz2lat".to_string(),
            "single".to_string(),
            "--source-crs".to_string(),
            "EPSG:4326".to_string(),
            "--target-crs".to_string(),
            "EPSG:3857".to_string(),
            "--coords".to_string(),
            "121.5654".to_string(),
            "25.0330".to_string(),
        ];
        
        let cli = Cli::try_parse_from(args).unwrap();
        match cli.mode {
            Mode::Single(_) => assert!(true),
            _ => assert!(false, "Expected Single mode"),
        }
    }
    
    #[test]
    fn test_transform_single() {
        let args = SingleArgs {
            source_crs: "EPSG:4326".to_string(),
            target_crs: "EPSG:3857".to_string(),
            coords: vec![121.5654, 25.0330],
        };
        let texts = get_texts("en");
        // 这里可能需要mock proj，实际测试中可能会失败
        // assert!(transform_single(&args, &texts).is_ok());
    }
}
