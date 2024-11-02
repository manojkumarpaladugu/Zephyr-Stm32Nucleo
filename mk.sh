set -euo pipefail

export CMAKE_BUILD_PARALLEL_LEVEL=${CMAKE_BUILD_PARALLEL_LEVEL:-$(nproc --all)}

# Returns empty string if $1 is empty, otherwise returns $1
cmake_preset=${1:-}
if [[ -z "${cmake_preset}" ]]; then
    echo -e "Usage: ./mk.sh <cmake preset> <optional build args>\n"
    cmake --list-presets
fi

# Remove the first argument
shift

cmake --preset "${cmake_preset}"
cmake --build --preset "${cmake_preset}" "${@}"
