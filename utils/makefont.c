#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void convert_to_binary(char *input, char *output) {
    for (int i = 0; i < 8; ++i) {
        output[i] = (input[i] == '.') ? '0' : '1';
    }
    output[8] = '\0';
}

int is_valid_line(const char *line, size_t line_length) {
    if (!line_length)
        return 0;

    // Ensure the line contains only '.' and '*'
    for (size_t i = 0; i < line_length; ++i) {
        if (line[i] != '.' && line[i] != '*') {
            return 0;
        }
    }

    return 1;
}

void process_font_file(FILE *input_file, FILE *output_file, int binary_output) {
    char line[256];
    char binary_line[9];
    int char_num = -1;

    fprintf(output_file, "GLOBAL _hankaku\n");
    fprintf(output_file, "[SECTION .data]\n");
    fprintf(output_file, "_hankaku:\n");

    while (fgets(line, sizeof(line), input_file)) {
        // Remove newline characters at the end of the line
        line[strcspn(line, "\r\n")] = '\0';
        size_t line_length = strlen(line);

        if (strncmp(line, "char 0x", 7) == 0) {
            fprintf(output_file, "    ;%s\n", line);
        } else if (is_valid_line(line, line_length)) {
            convert_to_binary(line, binary_line);
            if (binary_output) {
                fprintf(output_file, "    DB %sB\n", binary_line);
            } else {
                int hex_value = strtol(binary_line, NULL, 2);
                fprintf(output_file, "    DB %02Xh\n", hex_value);
            }
        }
    }
}

void print_usage(const char *program_name) {
    fprintf(stderr, "Usage: %s [-i input_file] [-o output_file] [-f output_format]\n", program_name);
    fprintf(stderr, "output_format: 0 for hex (default), 1 for binary\n");
}

int main(int argc, char *argv[]) {
    int opt;
    char *input_filename = NULL;
    char *output_filename = NULL;
    int binary_output = 0; // Default to hex format

    while ((opt = getopt(argc, argv, "i:o:f:")) != -1) {
        switch (opt) {
            case 'i':
                input_filename = optarg;
                break;
            case 'o':
                output_filename = optarg;
                break;
            case 'f':
                binary_output = atoi(optarg);
                if (binary_output != 0 && binary_output != 1) {
                    fprintf(stderr, "Invalid output format. Use 0 for hex and 1 for binary.\n");
                    return EXIT_FAILURE;
                }
                break;
            default:
                print_usage(argv[0]);
                return EXIT_FAILURE;
        }
    }

    if (!input_filename || !output_filename) {
        print_usage(argv[0]);
        return EXIT_FAILURE;
    }

    FILE *input_file = fopen(input_filename, "r");
    if (!input_file) {
        perror("Error opening input file");
        return EXIT_FAILURE;
    }

    FILE *output_file = fopen(output_filename, "w");
    if (!output_file) {
        perror("Error opening output file");
        fclose(input_file);
        return EXIT_FAILURE;
    }

    process_font_file(input_file, output_file, binary_output);

    fclose(input_file);
    fclose(output_file);
    return EXIT_SUCCESS;
}
