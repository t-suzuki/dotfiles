/******************************************************************************
 * \file 
 * \brief
 * \author
 *****************************************************************************/
#include <iostream>

#include <boost/program_options.hpp>

using namespace std;
namespace bpo = boost::program_options;

po::variables_map parse_options(int argc, char *argv[]) {
  po::options_description desc;
  desc.add_options()
    ("help,h", "show this message")
    ("test,t", "test option")
    ;
  po::variables_map vmap;
  po::store(po::parse_command_line(argc, argv, desc), vmap);

  if (vmap.count("help")) {
    cout << desc << endl;
    exit(0);
  }
  return vmap;
}

int main(int argc, char *argv[]) {
  po::variable_map vmap = parse_options(argc, argv);

  return 0;
}

/* vim: set et sts=2 sw=2 ts=2 fdm=syntax: */
