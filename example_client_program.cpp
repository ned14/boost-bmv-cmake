/* Little program using boost::system to demo it works
*/

// cmake ensures this is found
#include "boost/system/error_code.hpp"

#include <iostream>

int main(void)
{
  boost::system::error_code ec;
  std::cout << ec << std::endl;
  return 0;
}