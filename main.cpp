#include <iostream>

#include <fmt/core.h>
#include <opensubdiv/version.h>

int main()
{
  fmt::print("Hello OpenSubDiv\n");
  fmt::print("  Version: {}.{}.{}\n",
      OPENSUBDIV_VERSION_MAJOR,
      OPENSUBDIV_VERSION_MINOR,
      OPENSUBDIV_VERSION_PATCH);
  return 0;
}
