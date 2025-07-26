// src/cli.rs

use crate::texts::get_texts;
use clap::{Args, Parser, Subcommand};

#[derive(Parser, Debug)]
#[command(author, version)]
pub struct Cli {
    #[command(subcommand)]
    pub mode: Mode,

    /// 选择帮助文档和输出信息的语言 (zh/en)
    #[arg(long, global = true, default_value = "zh")]
    pub lang: String,
}

#[derive(Subcommand, Debug)]
pub enum Mode {
    /// 转换单个坐标点
    Single(SingleArgs),
    /// 从文件批量转换坐标
    File(FileArgs),
}

#[derive(Args, Debug)]
pub struct SingleArgs {
    /// 源坐标系
    #[arg(long, short, help=get_texts("zh").source_crs_help, long_help=get_texts("en").source_crs_help)]
    pub source_crs: String,
    /// 目标坐标系
    #[arg(long, short, help=get_texts("zh").target_crs_help, long_help=get_texts("en").target_crs_help)]
    pub target_crs: String,

    /// 要转换的坐标 (x y)
    #[arg(long, required = true, num_args = 2, value_delimiter = ' ', help=get_texts("zh").coords_help, long_help=get_texts("en").coords_help)]
    pub coords: Vec<f64>,
}

#[derive(Args, Debug)]
pub struct FileArgs {
    /// 源坐标系
    #[arg(long, short, help=get_texts("zh").source_crs_help, long_help=get_texts("en").source_crs_help)]
    pub source_crs: String,
    /// 目标坐标系
    #[arg(long, short, help=get_texts("zh").target_crs_help, long_help=get_texts("en").target_crs_help)]
    pub target_crs: String,
    /// 输入CSV文件路径
    #[arg(long, short, help=get_texts("zh").input_file_help, long_help=get_texts("en").input_file_help)]
    pub input_file: String,
    /// 输出CSV文件路径
    #[arg(long, short, help=get_texts("zh").output_file_help, long_help=get_texts("en").output_file_help)]
    pub output_file: String,
}
