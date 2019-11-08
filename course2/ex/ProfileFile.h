#ifndef PROFILE_FILE
#define PROFILE_FILE

#include <map>
#include <vector>

using Id2InstrValues = std::map<size_t, std::vector<size_t>>;

Id2InstrValues ReadProfile(std::string const &);

#endif
