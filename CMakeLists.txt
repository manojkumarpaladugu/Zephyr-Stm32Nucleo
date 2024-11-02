cmake_minimum_required(VERSION 3.28.3)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(ZEPHYR-STM32-NUCLEO)

target_sources(app PRIVATE Application/Main.c)
