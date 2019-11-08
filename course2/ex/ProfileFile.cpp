#include "ProfileFile.h"
#include <cstdint>
#include <cstdio>

#include <llvm/Support/raw_ostream.h>

Id2InstrValues ReadProfile(std::string const &ProfileFileName) {
  Id2InstrValues Map;

  FILE * ProfileFile = fopen(ProfileFileName.c_str(), "r");
  if(!ProfileFile)
    return Map;

  while(true) {
    uint64_t id, val;
    if(fscanf(ProfileFile, "%ld %ld\n", &id, &val) != 2)
      break;

    std::vector<uint64_t> Val = {val};
    std::pair<uint64_t, std::vector<uint64_t>> NewEntry(id, Val);
    auto Entry = Map.insert(NewEntry);
    if(Entry.second) // it's been inserted
      continue;
    // not inserted, add it
    Entry.first->second.push_back(val);
  }
  fclose(ProfileFile);
  return Map;
}
