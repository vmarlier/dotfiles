# Function to display usage instructions
helper() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  -a, --option-a: Perform action A"
    echo "  -b, --option-b: Perform action B"
    echo "  -c, --option-c: Perform action C"
}

# display the list of available virtual_env and choose one
#chooseList()

# get list of available virtual_env
#pewList() {}

# call pewWorkon to switch the virtual_env
pewWorkon() {
    pew workon $1
}

# call nvim to open nvim once in the virtual_env
openNvim() {
    nvim .
}

## check ~/Git folder to have a list of all the repositories
#getLocalRepos() {}

## add the list from getLocalRepos() to pew
#pewAddList() {}

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    echo "No argument provided."
    helper
    exit 1
fi

# Parse command line arguments
case $1 in
    -a|--option-a)
        echo "Performing action A"
        # Call function to perform action A
        ;;
    -b|--option-b)
        echo "Performing action B"
        # Call function to perform action B
        ;;
    *)
        pewWorkon $1
        openNvim
        ;;
esac
