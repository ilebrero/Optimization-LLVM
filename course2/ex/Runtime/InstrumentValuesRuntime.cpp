#include <cstdint>
#include <cstdio>
#include <cstdlib>


namespace {

struct FileLifetime {
  FileLifetime() {
    char* file_name = getenv("INSTR_FILE");
    if(!file_name) {
      fprintf(stderr, "Please specify instrumentation file" 
                      " by setting environment variable INSTR_FILE.\n");
      exit(-1);
    }
    file_ = fopen(file_name, "a");
    if(!file_) {
      fprintf(stderr, "Could not open file %s.\n", file_name);
      exit(-1);
    }
  }

  ~FileLifetime() {
    if(file_) {
      fclose(file_);
      file_ = nullptr;
    }
  }

  FILE *file_ = nullptr;
};

FileLifetime instr_file;

}

extern "C" void __instrument_value(uint64_t id, uint64_t val) {
  fprintf(instr_file.file_, "%lu %lu\n", id, val);
}
