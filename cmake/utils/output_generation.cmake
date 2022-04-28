
include(color_print)

function(ti_bin2hex target)
  find_program(
    BIN2HEX
    NAMES ${TI_OBJDUMP}
    HINTS ${TOOLCHAIN_DIR})

  if(NOT BIN2HEX)
    color_print(red "No ${TI_OBJDUMP} program was found")
    message(SEND_ERROR "")
  endif()

  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMENT "Generating ${target} executable!"
    DEPENDS ${PROJECT_BINARY_DIR}/bin/${target}
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/bin
    COMMAND "${BIN2HEX}" --boot --gpio8 --ascii -o "${target}.a00" "${target}")

    set_property(
        DIRECTORY
        APPEND
      PROPERTY ADDITIONAL_MAKE_CLEAN_FILES ${PROJECT_BINARY_DIR}/bin/${target}.out ${PROJECT_BINARY_DIR}/bin/${target}.a00)
endfunction()

function(esp_bin2hex target)
"python3 ${PLATFORM_PROJECT_LOCATION}/platform/ESP8266/Arduino/tools/elf2bin.py" 
                --eboot "${PLATFORM_PROJECT_LOCATION}/platform/ESP8266/Arduino/bootloaders/eboot/eboot.elf" 
                --app "C:\\Users\\Riko\\AppData\\Local\\Temp\\arduino_build_652563/NeoPixel_7_Segment_Clock.ino.elf" 
                --flash_mode dio --flash_freq 40 --flash_size 4M 
                --path "C:\\Users\\Riko\\AppData\\Local\\Arduino15\\packages\\esp8266\\tools\\xtensa-lx106-elf-gcc\\2.5.0-4-b40a506/bin" 
                --out "C:\\Users\\Riko\\AppData\\Local\\Temp\\arduino_build_652563/NeoPixel_7_Segment_Clock.ino.bin"
endfunction()
