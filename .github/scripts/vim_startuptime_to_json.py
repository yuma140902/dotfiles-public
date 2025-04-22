import json
import pathlib
import argparse
import dataclasses
import datetime
import logging

# ロガーの準備
# https://stackoverflow.com/questions/10973362/python-logging-function-name-file-name-line-number-using-a-single-file
logger = logging.getLogger(__name__)
FORMAT = "[%(filename)s:%(lineno)s - %(funcName)20s() ] %(message)s"
logging.basicConfig(format=FORMAT)
logger.setLevel(logging.DEBUG)

@dataclasses.dataclass
class Detail:
    average_ms: float
    max_ms: float
    min_ms: float
    subject: str

@dataclasses.dataclass
class BenchmarkResult:
    datetime: str
    branch: str
    average_ms: float
    max_ms: float
    min_ms: float

def reset_benchmarks_json(path: pathlib.Path) -> None:
    """benchmarks.jsonをリセットする

    Args:
        path: benchmarks.jsonの場所
    """
    logger.debug(f'resetting {path}')
    with open(path, mode='w+', encoding='UTF-8') as f:
        f.write('{"benchmarks": []}')
    logger.debug(f'reset {path}')

def append_to_benchmarks_json(result: BenchmarkResult, path: pathlib.Path) -> None:
    """benchmarks.jsonにベンチマーク結果を追加する

    Args:
        result: ベンチマーク結果
        path: benchmarks.jsonの場所
    """
    logger.debug(f'loading benchmarks from {path}')
    with open(path, mode='r', encoding='UTF-8') as f:
        obj = json.load(f)
    logger.debug(f'loaded benchmarks from {path}')
    obj['benchmarks'].append(dataclasses.asdict(result))
    logger.debug(f'writing benchmarks to {path}')
    with open(path, mode='w+', encoding='UTF-8') as f:
        json.dump(obj, f)
    logger.debug(f'wrote benchmarks to {path}')

def parse_startuptime_result(branch: str, now: str, lines: list[str]) -> BenchmarkResult:
    """vim-startuptimeの実行結果をパースしする

    Args:
        lines: vim-startuptimeの実行結果のテキスト
    """
    average_ms = -1
    max_ms = -1
    min_ms = -1
    details_mode = False
    details = []

    logger.debug('parsing vim-startuptime result')
    for line in lines:
        if line.startswith('Total Average'):
            parts = line.split()
            average_ms = float(parts[2])
            logger.debug(f'found average_ms: {average_ms}')
        elif line.startswith('Total Max'):
            parts = line.split()
            max_ms = float(parts[2])
            logger.debug(f'found max_ms: {max_ms}')
        elif line.startswith('Total Min'):
            parts = line.split()
            min_ms = float(parts[2])
            logger.debug(f'found min_ms: {min_ms}')
        elif line.startswith('-----'):
            details_mode = True
            logger.debug('entering details_mode')
        elif details_mode:
            parts = line.split(sep=':', maxsplit=1)
            logger.debug('parsing details', parts)
            if len(parts) <= 2:
                logger.warning('unexpected line without ":"', line)
                continue
            times = parts[0].split()
            detail_avg = float(times[0])
            detail_max = float(times[1])
            detail_min = float(times[2])
            subject = parts[1].strip()
            detail = Detail(
                average_ms=detail_avg,
                max_ms=detail_max,
                min_ms=detail_min,
                subject=subject
            )
            details.append(detail)

    assert average_ms >= 0
    assert max_ms >= 0
    assert min_ms >= 0
    benchmark_result = BenchmarkResult(
        datetime=now,
        branch=branch,
        average_ms=average_ms,
        max_ms=max_ms,
        min_ms=min_ms,
    )
    return benchmark_result

def main(args) -> None:
    logger.debug(f'args={args}')
    input_path = pathlib.Path(args.input)
    output_path = pathlib.Path(args.output)

    # 入力ファイルが存在しなければエラー
    if not input_path.is_file():
        logger.error(f'{input_path} is not file')
        raise Exception(f'{input_path} is not file')

    # 出力ファイル(benchmarks.json)が存在しなければ初期化する
    if not output_path.is_file():
        reset_benchmarks_json(output_path)

    with open(input_path, mode='r', encoding='UTF-8') as f:
        startuptime_text = f.readlines()

    branch = args.branch
    now = datetime.datetime.now().isoformat()
    benchmark_result = parse_startuptime_result(branch, now, startuptime_text)
    logger.debug(f'benchmark_result={benchmark_result}')
    append_to_benchmarks_json(benchmark_result, output_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', required=True)
    parser.add_argument('-o', '--output', required=True)
    parser.add_argument('-b', '--branch', required=True)
    args = parser.parse_args()
    main(args)
