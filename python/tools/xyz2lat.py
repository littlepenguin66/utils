#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
A powerful and user-friendly command-line coordinate transformation tool.

This script utilizes the pyproj library to perform transformations between various
Coordinate Reference Systems (CRS). It supports two primary modes of operation:
1. 'single': Transforms a single 2D or 3D coordinate point provided on the
             command line.
2. 'file': Batch transforms coordinates from a source CSV file and saves the
           results to a new output CSV file.

The script is bilingual (English/Chinese) for all user-facing messages,
including help documentation and error feedback.

Dependencies:
    - pyproj
"""

import argparse
import csv
import sys

from pyproj import CRS, Transformer
from pyproj.exceptions import CRSError

# --- Bilingual Help Texts & Messages Definition ---
# This dictionary stores all user-facing strings for easy localization.
HELP_TEXTS = {
    "zh": {
        "description": "一个功能强大的坐标转换工具，使用 pyproj 库在不同的坐标参考系统 (CRS) 之间进行转换。",
        "epilog": """
使用示例:

1. 转换单个坐标点 (WGS84 经纬度 -> WGS84 / UTM zone 51N):
   python %(prog)s single --source_crs EPSG:4326 --target_crs EPSG:32651 --coords 121.5654 25.0330

2. 从文件批量转换 (北京 1954 / 3-degree Gauss-Kruger zone 40 -> WGS84):
   python %(prog)s file --source_crs EPSG:2436 --target_crs EPSG:4326 --input_file input.csv --output_file output.csv

3. 使用 PROJ 字符串进行转换:
   python %(prog)s single --source_crs "EPSG:4326" --target_crs "+proj=utm +zone=51 +datum=WGS84" --coords 121.56 25.03
""",
        "lang_help": "选择帮助文档和输出信息的语言 (zh/en)。",
        "mode_help": "选择操作模式: 'single' (转换单个坐标点) 或 'file' (从文件批量转换)。",
        "source_crs_help": "定义源坐标参考系统。可以是 EPSG 代码 (如 'EPSG:4326') 或 PROJ 字符串。\n您可以在 https://epsg.io/ 网站上查找 EPSG 代码。",
        "target_crs_help": "定义目标坐标参考系统。可以是 EPSG 代码 (如 'EPSG:32651') 或 PROJ 字符串。\n您可以在 https://epsg.io/ 网站上查找 EPSG 代码。",
        "coords_help": "在 'single' 模式下，提供要转换的坐标。接受2个或3个值，用空格分隔 (例如: 120.5 31.8 或 120.5 31.8 100)。",
        "input_file_help": "在 'file' 模式下，指定包含源坐标的输入CSV文件路径。文件第一行应为表头 (例如 'lon,lat')。",
        "output_file_help": "在 'file' 模式下，指定用于保存转换结果的输出CSV文件路径。",
        "error_crs_creation": "错误：无法创建坐标参考系统。请检查您的EPSG代码或PROJ字符串是否正确。",
        "error_pyproj": "Pyproj 错误",
        "error_single_coords_missing": "错误: 在 'single' 模式下, 必须使用 --coords 提供2个或3个坐标值。",
        "error_file_args_missing": "错误: 在 'file' 模式下, 必须同时提供 --input_file 和 --output_file。",
        "transform_result": "转换结果",
        "file_transform_complete": "文件转换完成！结果已保存至",
        "warning_skip_row": "警告：跳过格式错误的行",
        "error_input_not_found": "错误：输入文件未找到。",
        "error_processing_file": "处理文件时发生错误",
    },
    "en": {
        "description": "A powerful coordinate transformation tool using pyproj to convert between different Coordinate Reference Systems (CRS).",
        "epilog": """
Usage Examples:

1. Transform a single point (WGS84 lat/lon -> WGS84 / UTM zone 51N):
   python %(prog)s single --source_crs EPSG:4326 --target_crs EPSG:32651 --coords 121.5654 25.0330

2. Batch transform from a file (Beijing 1954 / 3-degree Gauss-Kruger zone 40 -> WGS84):
   python %(prog)s file --source_crs EPSG:2436 --target_crs EPSG:4326 --input_file input.csv --output_file output.csv

3. Transform using a PROJ string:
   python %(prog)s single --source_crs "EPSG:4326" --target_crs "+proj=utm +zone=51 +datum=WGS84" --coords 121.56 25.03
""",
        "lang_help": "Choose the language for help documentation and output messages (zh/en).",
        "mode_help": "Select operation mode: 'single' (for a single point) or 'file' (for batch conversion from a file).",
        "source_crs_help": "Define the source Coordinate Reference System. Can be an EPSG code (e.g., 'EPSG:4326') or a PROJ string.\nFind EPSG codes at https://epsg.io/",
        "target_crs_help": "Define the target Coordinate Reference System. Can be an EPSG code (e.g., 'EPSG:32651') or a PROJ string.\nFind EPSG codes at https://epsg.io/",
        "coords_help": "In 'single' mode, the coordinates to be transformed. Accepts 2 or 3 values, separated by spaces (e.g., 120.5 31.8 or 120.5 31.8 100).",
        "input_file_help": "In 'file' mode, the path to the input CSV file containing source coordinates. The first row should be a header (e.g., 'lon,lat').",
        "output_file_help": "In 'file' mode, the path to the output CSV file to save transformation results.",
        "error_crs_creation": "Error: Failed to create Coordinate Reference System. Please check if your EPSG code or PROJ string is correct.",
        "error_pyproj": "Pyproj Error",
        "error_single_coords_missing": "Error: In 'single' mode, you must provide 2 or 3 coordinate values using --coords.",
        "error_file_args_missing": "Error: In 'file' mode, both --input_file and --output_file must be provided.",
        "transform_result": "Transformation Result",
        "file_transform_complete": "File transformation complete! Results saved to",
        "warning_skip_row": "Warning: Skipping malformed row",
        "error_input_not_found": "Error: Input file not found.",
        "error_processing_file": "An error occurred while processing the file",
    },
}


def create_transformer(source_crs_def, target_crs_def, lang_texts):
    """
    Creates a pyproj Transformer object based on user-defined CRS.

    Args:
        source_crs_def (str): The definition for the source CRS (e.g., "EPSG:4326").
        target_crs_def (str): The definition for the target CRS (e.g., "EPSG:32651").
        lang_texts (dict): The dictionary of localized strings for error messages.

    Returns:
        pyproj.Transformer: The configured transformer object for coordinate conversions.

    Raises:
        SystemExit: If CRS creation fails.
    """
    try:
        source_crs = CRS.from_user_input(source_crs_def)
        target_crs = CRS.from_user_input(target_crs_def)
        # always_xy=True ensures (lon, lat) order for geographic coordinates
        return Transformer.from_crs(source_crs, target_crs, always_xy=True)
    except CRSError as e:
        print(f"{lang_texts['error_crs_creation']}")
        print(f"{lang_texts['error_pyproj']}: {e}")
        sys.exit(1)


def transform_coords(transformer, coords):
    """
    Transforms a single coordinate point (2D or 3D).

    Args:
        transformer (pyproj.Transformer): The transformer object.
        coords (list[float]): A list containing 2 or 3 coordinate values.

    Returns:
        tuple: A tuple containing the transformed coordinates.
    """
    return transformer.transform(*coords)


def transform_file(transformer, input_file, output_file, lang_texts):
    """
    Reads coordinates from a source CSV, transforms them, and writes to a new CSV.

    The input CSV file is expected to have a header row. Each subsequent row
    should contain the coordinate values in its initial columns.
    The output CSV will contain all original columns plus the new transformed
    coordinate columns.

    Args:
        transformer (pyproj.Transformer): The transformer object.
        input_file (str): Path to the source CSV file.
        output_file (str): Path for the destination CSV file.
        lang_texts (dict): The dictionary of localized strings for messages.

    Raises:
        SystemExit: If the input file is not found or a processing error occurs.
    """
    try:
        with (
            open(input_file, "r", newline="", encoding="utf-8-sig") as infile,
            open(output_file, "w", newline="", encoding="utf-8") as outfile,
        ):
            reader = csv.reader(infile)
            writer = csv.writer(outfile)

            # Read and process the header
            header = next(reader)
            num_input_cols = len(header)

            # Dynamically generate the output header
            new_header = list(header)
            if num_input_cols >= 2:
                new_header.extend(["transformed_x", "transformed_y"])
            if num_input_cols >= 3:
                new_header.append("transformed_z")  # Overwrite previous z if needed
                new_header[num_input_cols + 2 - 1] = "transformed_z"
            writer.writerow(new_header)

            # Process each data row
            for i, row in enumerate(reader, start=2):  # Start from line 2
                if not row or len(row) < num_input_cols:
                    print(
                        f"{lang_texts['warning_skip_row']} (line {i}): {row}. Reason: Incomplete row."
                    )
                    continue
                try:
                    # Assume coordinate values are the first N columns matching header
                    coords_in = [float(c) for c in row[:num_input_cols]]

                    coords_out = transform_coords(transformer, coords_in)

                    # Append new coordinates to the original row data
                    writer.writerow(row + list(coords_out))
                except (ValueError, IndexError) as e:
                    print(
                        f"{lang_texts['warning_skip_row']} (line {i}): {row}. Reason: {e}"
                    )
                    continue

        print(f"{lang_texts['file_transform_complete']} {output_file}")

    except FileNotFoundError:
        print(f"{lang_texts['error_input_not_found']}: {input_file}")
        sys.exit(1)
    except Exception as e:
        print(f"{lang_texts['error_processing_file']}: {e}")
        sys.exit(1)


def main():
    """Main function to parse arguments and orchestrate the transformation."""

    # --- Pre-parse the language argument ---
    # This allows the help message itself to be displayed in the correct language.
    pre_parser = argparse.ArgumentParser(add_help=False)
    pre_parser.add_argument("--lang", default="zh", choices=["zh", "en"])
    pre_args, _ = pre_parser.parse_known_args()
    lang = pre_args.lang
    texts = HELP_TEXTS[lang]

    # --- Main Argument Parser ---
    parser = argparse.ArgumentParser(
        description=texts["description"],
        # Use RawTextHelpFormatter to preserve formatting in help messages and epilog
        formatter_class=argparse.RawTextHelpFormatter,
        epilog=texts["epilog"],
    )

    parser.add_argument(
        "--lang", default=lang, choices=["zh", "en"], help=texts["lang_help"]
    )
    parser.add_argument("mode", choices=["single", "file"], help=texts["mode_help"])
    parser.add_argument("--source_crs", required=True, help=texts["source_crs_help"])
    parser.add_argument("--target_crs", required=True, help=texts["target_crs_help"])
    parser.add_argument("--coords", nargs="*", type=float, help=texts["coords_help"])
    parser.add_argument("--input_file", help=texts["input_file_help"])
    parser.add_argument("--output_file", help=texts["output_file_help"])

    args = parser.parse_args()

    # If the user specified --lang again, this ensures we use that choice.
    if args.lang != lang:
        texts = HELP_TEXTS[args.lang]

    transformer = create_transformer(args.source_crs, args.target_crs, texts)

    if args.mode == "single":
        if not args.coords or len(args.coords) not in [2, 3]:
            print(texts["error_single_coords_missing"])
            parser.print_help()
            sys.exit(1)

        new_coords = transform_coords(transformer, args.coords)
        # Format output to a reasonable number of decimal places for readability
        formatted_coords = ", ".join([f"{c:.6f}" for c in new_coords])
        print(f"{texts['transform_result']}: {formatted_coords}")

    elif args.mode == "file":
        if not args.input_file or not args.output_file:
            print(texts["error_file_args_missing"])
            parser.print_help()
            sys.exit(1)
        transform_file(transformer, args.input_file, args.output_file, texts)


if __name__ == "__main__":
    main()
