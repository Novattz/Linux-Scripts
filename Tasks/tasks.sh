#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
CHECKMARK='\u2713'

TASK_DIR="Tasks"

if [ ! -d "$TASK_DIR" ]; then
    mkdir "$TASK_DIR"
fi

TODO_FILE="$TASK_DIR/to-do.list"
DONE_FILE="$TASK_DIR/to-do.list.done"

if [ ! -f "$TODO_FILE" ]; then
    touch "$TODO_FILE"
fi
if [ ! -f "$DONE_FILE" ]; then
    touch "$DONE_FILE"
fi

display_to_do_list() {
    echo -e "\nTo do list - $(date)\n==============\n"
    i=1
    while read -r line; do
        if [[ $line == \** ]]; then
            echo -e "$i. ${RED}$line${NC}"
        else
            echo "$i. $line"
        fi
        i=$((i+1))
    done < "$TODO_FILE"
    echo ""
}

mark_as_done() {
    echo "Please enter the number of the item you want to mark as done:"
    read -r num
    line=$(sed "${num}q;d" "$TODO_FILE")
    echo "$line - Completed" >> "$DONE_FILE"
    sed -i "${num}d" "$TODO_FILE"
}

remove_item() {
    echo "Please enter the number of the item you want to remove:"
    read -r num
    sed -i "${num}d" "$TODO_FILE"
}

remove_completed_item() {
    echo "Please enter the number of the completed task you want to remove:"
    read -r num
    sed -i "${num}d" "$DONE_FILE"
}

display_done_list() {
    while true; do
        clear
        echo -e "\nCompleted tasks:\n==============\n"
        i=1
        while read -r line; do
            line=${line#\* }
            line=${line% - Completed}
            echo -e "${i}. ${GREEN}${line} ${CHECKMARK}${NC}"
            i=$((i+1))
        done < "$DONE_FILE"

        echo -e "\nOptions:\n1. Remove a completed task\n2. Return to main menu"
        read -p "Please enter your choice: " completed_choice

        case $completed_choice in
            1)
                remove_completed_item
                ;;
            2)
                break
                ;;
            *)
                echo -e "\nInvalid choice, try again.\n"
                ;;
        esac
    done
}

add_item() {
    echo "Please write what you want to add to the list:"
    read -r item
    echo "Mark with priority? (Y/N)"
    read -r priority
    if [ "$priority" = "Y" ] || [ "$priority" = "y" ]; then
        echo "* $item" >> "$TODO_FILE"
    else
        echo "$item" >> "$TODO_FILE"
    fi
}

# Main loop
while true; do
    clear
    display_to_do_list
    echo -e "1. Add item\n2. Mark as done\n3. Display completed tasks\n4. Remove item\n5. Exit\n"
    read -p "Please enter your choice (1-5): " choice
    case $choice in
        1)
            add_item
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        2)
            mark_as_done
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        3)
            display_done_list
            ;;
        4)
            remove_item
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        5)
            break
            ;;
        *)
            echo -e "\nInvalid choice, try again.\n"
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
    esac
done
