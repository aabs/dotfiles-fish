#!/usr/bin/env fish

# The purpose of this script is to create and destroy test environments, 
# and test the operation of the fishshell installation process without 
# being destructive of my personal home directory

function fixture -d "run all the tests"
    set test_path (setup)
    set -g errors ""
    run_tests $test_path
    if test -n $errors
      echo "Errors:"
      printf $errors
      set -g errors ""
    else
      echo "all tests passed"
    end
    teardown $test_path
    cd ~/dev/fishdots
end

function run_tests -a test_path -d "description"
  test_existence_of_test_files $test_path 
  test_installation $test_path
end

function setup -d "set everything up"
    set test_path (create_test_folder)
    echo $test_path
end

function teardown -a test_path -d "clean up"
    # remove_home_folder_structure $test_path
end

function on_fail --on-event failed_unit_test -a msg
  set -g errors "$errors \n  - $msg"
end

function fail -a msg
  emit failed_unit_test $msg
end


function create_test_folder -d "creates a temporary directory for testing"
    set test_path ( get_test_folder (get_base_path) )
    setup_home_folder_structure $test_path
    echo $test_path
end

function get_base_path -d "find a place for the test directory to go"
    echo "$HOME/tmp/fishdots_test"
end

function get_test_folder -a base_path -d "generates a name for a test folder and creates it"
    set ts (date +%s)
    set p "$base_path/$ts"
    echo $p
end

function setup_home_folder_structure -a test_path -d "places sample home folder files and folders into the test folder"
    mkdir -p $test_path
    tar xzf test_home_folder.tgz -C $test_path
end

function remove_home_folder_structure -a test_path -d "description"
    rm -rf $test_path
end

function is_file_under_control -a file_name -d "determines whether a file has been placed under indirection control"
    
end

function get_gen_of_file -a file_name -d "traces the location of a file and confirms where, within the generations system, it is located"
    
end

#  UNIT TESTS
###################################

function test_existence_of_test_files -a test_path 
  if not test -e $test_path/.local
    fail "test files were not present"
  end
end

function test_installation -a test_path
  set -x FISHDOTS_INSTALL_PATH $test_path
  source ./install.fish
  if not test -e $test_path/.config/fishdots/home
    fail "fishdots was not installed properly"
  end
end

abbr --add test 'make clean; source testing.fish; fixture'
