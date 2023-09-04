import json
import pathlib
import argparse
import dataclasses
import datetime

@dataclasses.dataclass
class BenchmarkResult:
    datetime: str
    branch: str
    average_ms: float
    max_ms: float
    min_ms: float
    full_text: list[str]

def reset_benchmarks_json(path: pathlib.Path) -> None:
    with open(path, mode='w', encoding='UTF-8') as f:
        f.write('{"benchmarks": []}')

def append_to_benchmarks_json(result: BenchmarkResult, path: pathlib.Path) -> None:
    with open(path, mode='r', encoding='UTF-8') as f:
        obj = json.load(f)
    obj.benchmarks.append(result)
    with open(path, mode='w', encoding='UTF-8') as f:
        json.dump(obj, f)

def parse_startuptime_result(lines: list[str]) -> tuple[float, float, float]:
    average_ms = -1
    max_ms = -1
    min_ms = -1
    for line in lines:
        if line.startswith('Total Average'):
            parts = line.split()
            average_ms = float(parts[2])
        elif line.startswith('Total Max'):
            parts = line.split()
            max_ms = float(parts[2])
        elif line.startswith('Total Min'):
            parts = line.split()
            min_ms = float(parts[2])
    return (average_ms, max_ms, min_ms)

def main(args) -> None:
    input_path = pathlib.Path(args.input)
    output_path = pathlib.Path(args.output)
    if not input_path.is_file():
        raise Exception(f'{input_path} is not file')

    if not output_path.is_file():
        reset_benchmarks_json(output_path)

    with open(input_path, mode='r', encoding='UTF-8') as f:
        startuptime_text = f.readlines()

    (average_ms, max_ms, min_ms) = parse_startuptime_result(startuptime_text)
    branch = args.branch
    now = datetime.datetime.now().isoformat()
    benchmark_result = BenchmarkResult(
        datetime=now,
        branch=branch,
        average_ms=average_ms,
        max_ms=max_ms,
        min_ms=min_ms,
        full_text=startuptime_text
    )
    append_to_benchmarks_json(benchmark_result, output_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', required=True)
    parser.add_argument('-o', '--output', required=True)
    parser.add_argument('-b', '--branch', required=True)
    args = parser.parse_args()
    main(args)
