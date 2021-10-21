#include <iostream>

#include <opensubdiv/version.h>

int main()
{
  std::cout << "Hello OpenSubDiv\n";
  std::cout << "  Version: " <<
    OPENSUBDIV_VERSION_MAJOR << "." <<
    OPENSUBDIV_VERSION_MINOR << "." <<
    OPENSUBDIV_VERSION_PATCH << "\n";
  return 0;
}
