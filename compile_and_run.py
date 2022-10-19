import subprocess
import os
from pathlib import Path

def run_cmd(command, command_env = {}):
    curr_env = os.environ.copy()
    next_env = curr_env | command_env
    process = subprocess.Popen(command.split(), stdout=subprocess.PIPE, env=next_env)
    output, error = process.communicate()
    return output, error

def compile_stream(n_elements):
    command = "make"
    env = {"ARRAY_SIZE": f"{n_elements}"}
    output, error = run_cmd(command, env)
    return output, error

def execute_stream(n_elements):
    command = f"./stream_c.{n_elements}"
    output, error = run_cmd(command)
    return output, error

def compile_and_run(n_elements, output_file):
    output, error = compile_stream(n_elements)
    assert(not error)
    output, error = execute_stream(n_elements)
    assert(not error)
    with open(output_file, "wb") as f:
        f.write(output)

def get_n_elements(LLC_size): # LLC_size in bytes
    return LLC_size // 8

if __name__ == "__main__":
    # HiFive Unmatched: 32KB L1 Dcache, 2MB L2 cache
    min_n_elements = get_n_elements(2 * 1024 * 1024) * 4
    max_n_elements = 1000 * min_n_elements
    step = min_n_elements
    output_folder = Path("results")
    output_folder.mkdir(exist_ok=True)

    for n_elements in range(min_n_elements, max_n_elements+1, step):
        output_path = output_folder / Path(f"{n_elements}.log")
        compile_and_run(n_elements, output_path)

