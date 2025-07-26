// src/main.rs

use clap::Parser;
use std::process;
use xyz2lat::{cli::Cli, run, texts::get_texts};

fn main() {
    let args: Vec<String> = std::env::args().collect();

    // 1. 从所有参数中查找 --lang，无论在根命令还是子命令位置
    let lang_code = extract_lang_from_all_positions(&args);

    // 2. 检查是否请求了帮助（包括子命令帮助）
    let help_requested = args.iter().any(|s| s == "--help" || s == "-h");

    if help_requested {
        // 如果请求了帮助，根据实际的语言构建对应的命令
        let texts = get_texts(&lang_code);

        // 动态构建命令结构以支持多语言帮助
        let cmd = build_command_with_language(&texts);

        // 使用 clap 提供的 try_get_matches_from 来解析参数，并自动处理子命令帮助
        match cmd.try_get_matches_from(&args) {
            Ok(_) => {
                // 正常流程，不应该走到这里（因为有 --help）
                unreachable!()
            }
            Err(e) => {
                // clap 会自动处理 --help 并退出程序
                e.exit();
            }
        }
    }

    // 3. 如果未请求帮助，则继续正常解析命令行参数。
    let cli = Cli::parse();

    // 4. 调用库的核心逻辑。
    if let Err(e) = run(cli) {
        eprintln!("Error: {}", e);
        process::exit(1);
    }
}

/// 从命令行参数的所有位置查找 --lang 参数
fn extract_lang_from_all_positions(args: &[String]) -> String {
    let mut lang_code = "zh".to_string(); // 默认语言为中文

    // 遍历所有参数，查找 --lang 后面的值
    for i in 0..args.len() {
        if args[i] == "--lang" && i + 1 < args.len() {
            let potential_lang = &args[i + 1];
            // 验证语言代码是否有效
            if potential_lang == "zh" || potential_lang == "en" {
                lang_code = potential_lang.clone();
                break;
            }
        }
    }

    lang_code
}

/// 根据语言构建多语言命令帮助
fn build_command_with_language(texts: &xyz2lat::texts::Texts) -> clap::Command {
    use clap::{Arg, Command};

    // 根据 texts 的内容判断当前语言
    let is_english = texts
        .description
        .contains("powerful coordinate transformation tool");
    let lang_help_text = if is_english {
        "Select the language for help documentation and output messages (zh/en)"
    } else {
        "选择帮助文档和输出信息的语言 (zh/en)"
    };

    Command::new("xyz2lat")
        .version(env!("CARGO_PKG_VERSION"))
        .author(env!("CARGO_PKG_AUTHORS"))
        .about(texts.description)
        .after_help(texts.epilog)
        .after_long_help(texts.epilog)
        .subcommand(
            Command::new("single")
                .about(texts.single_about)
                .arg(
                    Arg::new("source_crs")
                        .short('s')
                        .long("source-crs")
                        .help(texts.source_crs_help)
                        .required(true),
                )
                .arg(
                    Arg::new("target_crs")
                        .short('t')
                        .long("target-crs")
                        .help(texts.target_crs_help)
                        .required(true),
                )
                .arg(
                    Arg::new("coords")
                        .long("coords")
                        .help(texts.coords_help)
                        .num_args(2)
                        .required(true),
                )
                .arg(
                    Arg::new("lang")
                        .long("lang")
                        .help(lang_help_text)
                        .default_value("zh"),
                ),
        )
        .subcommand(
            Command::new("file")
                .about(texts.file_about)
                .arg(
                    Arg::new("source_crs")
                        .short('s')
                        .long("source-crs")
                        .help(texts.source_crs_help)
                        .required(true),
                )
                .arg(
                    Arg::new("target_crs")
                        .short('t')
                        .long("target-crs")
                        .help(texts.target_crs_help)
                        .required(true),
                )
                .arg(
                    Arg::new("input_file")
                        .short('i')
                        .long("input-file")
                        .help(texts.input_file_help)
                        .required(true),
                )
                .arg(
                    Arg::new("output_file")
                        .short('o')
                        .long("output-file")
                        .help(texts.output_file_help)
                        .required(true),
                )
                .arg(
                    Arg::new("lang")
                        .long("lang")
                        .help(lang_help_text)
                        .default_value("zh"),
                ),
        )
        .arg(
            Arg::new("lang")
                .long("lang")
                .global(true)
                .help(lang_help_text)
                .default_value("zh"),
        )
}
