// src/error.rs

use std::fmt;

/// 应用程序的统一错误类型
#[derive(Debug)]
pub enum AppError {
    /// 在创建 PROJ 转换对象时发生的错误
    CrsCreate(proj::ProjCreateError),
    /// 在进行坐标转换时发生的错误
    CrsTransform(proj::ProjError),
    /// 文件输入/输出错误
    Io(std::io::Error, String),
    /// CSV 解析或写入错误
    Csv(csv::Error),
    /// 其他通用错误
    Generic(String),
}

// 实现 Display trait，以便能友好地打印错误信息
impl fmt::Display for AppError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            AppError::CrsCreate(e) => write!(f, "CRS Creation Error: {}", e),
            AppError::CrsTransform(e) => write!(f, "CRS Transformation Error: {}", e),
            AppError::Io(e, path) => write!(f, "IO Error for file '{}': {}", path, e),
            AppError::Csv(e) => write!(f, "CSV Processing Error: {}", e),
            AppError::Generic(msg) => write!(f, "Error: {}", msg),
        }
    }
}

// 实现 Error trait
impl std::error::Error for AppError {}

// 实现 From trait，以便可以使用 `?` 运算符进行自动转换

impl From<proj::ProjCreateError> for AppError {
    fn from(err: proj::ProjCreateError) -> AppError {
        AppError::CrsCreate(err)
    }
}

impl From<proj::ProjError> for AppError {
    fn from(err: proj::ProjError) -> AppError {
        AppError::CrsTransform(err)
    }
}

impl From<csv::Error> for AppError {
    fn from(err: csv::Error) -> AppError {
        AppError::Csv(err)
    }
}

// 新增: 为 std::io::Error 实现 From
impl From<std::io::Error> for AppError {
    fn from(err: std::io::Error) -> AppError {
        // 当我们从 `?` 自动转换时，可能没有文件路径的上下文，
        // 所以我们提供一个通用的占位符。
        AppError::Io(err, "N/A".to_string())
    }
}
