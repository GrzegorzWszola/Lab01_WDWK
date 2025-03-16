cmake_minimum_required(VERSION 3.10)

# Set the project name and version
project(AssemblerApp VERSION 1.0 LANGUAGES C)

# Set the assembly source file with an explicit path
set(ASM_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/src/LabWDWK.asm)

# Set output executable name
set(EXECUTABLE_NAME Lab01)

# Specify the assembler flags (optional, can be customized based on your needs)
set(ASM_FLAGS "--32")  # Use 32-bit mode for assembly

# Specify the GCC flags for linking (m32 for 32-bit)
set(LINKER_FLAGS "-m32")  # Use 32-bit linking

# Specify the C compiler (though we are using GCC directly)
set(CMAKE_ASM_COMPILER as)  # Use the `as` assembler

# Set output file paths for object file and executable
set(OBJ_FILE ${CMAKE_BINARY_DIR}/LabWDWK.o)
set(EXEC_FILE ${CMAKE_BINARY_DIR}/${EXECUTABLE_NAME})

# Print the ASM source file path for debugging purposes
message(STATUS "ASM source file: ${ASM_SOURCE}")

# Use GCC to assemble and link the assembly file
add_custom_command(
    OUTPUT ${EXEC_FILE}
    COMMAND ${CMAKE_ASM_COMPILER} ${ASM_FLAGS} -o ${OBJ_FILE} ${ASM_SOURCE}  # Assemble the .asm file
    COMMAND gcc ${LINKER_FLAGS} -o ${EXEC_FILE} ${OBJ_FILE}  # Link the object to the executable
    DEPENDS ${ASM_SOURCE}  # When the source changes, recompile
)

# Add the custom target that runs the commands above
add_custom_target(run ALL DEPENDS ${EXEC_FILE})

