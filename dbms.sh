#!/bin/bash

DB_PATH="./databases"

# Ensure the database directory exists
mkdir -p $DB_PATH

# Create Database
create_database() {
    read -p "Enter database name: " db_name
    if [[ -d "$DB_PATH/$db_name" ]]; then
        echo "Database $db_name already exists."
    else
        mkdir "$DB_PATH/$db_name"
        echo "Database $db_name created."
    fi
}

# List Databases
list_databases() {
    echo "Databases:"
    ls $DB_PATH
}

# Connect To Database
connect_database() {
    read -p "Enter database name: " db_name
    if [[ -d "$DB_PATH/$db_name" ]]; then
        db_connection="$DB_PATH/$db_name"
        echo "Connected to database $db_name."
    else
        echo "Database $db_name does not exist."
        db_connection=""
    fi
}

# Drop Database
drop_database() {
    read -p "Enter database name: " db_name
    if [[ -d "$DB_PATH/$db_name" ]]; then
        rm -r "$DB_PATH/$db_name"
        echo "Database $db_name dropped."
    else
        echo "Database $db_name does not exist."
    fi
}

# Create Table
create_table() {
    if [[ -z $db_connection ]]; then
        echo "No database connected."
        return
    fi

    read -p "Enter table name: " table_name
    read -p "Enter columns (comma-separated): " columns
    if [[ -f "$db_connection/$table_name" ]]; then
        echo "Table $table_name already exists."
    else
        echo "$columns" > "$db_connection/$table_name"
        echo "Table $table_name created with columns: $columns"
    fi
}

# List Tables
list_tables() {
    if [[ -z $db_connection ]]; then
        echo "No database connected."
        return
    fi

    echo "Tables:"
    ls $db_connection
}

# Drop Table
drop_table() {
    if [[ -z $db_connection ]]; then
        echo "No database connected."
        return
    fi

    read -p "Enter table name: " table_name
    if [[ -f "$db_connection/$table_name" ]]; then
        rm "$db_connection/$table_name"
        echo "Table $table_name dropped."
    else
        echo "Table $table_name does not exist."
    fi
}

# Insert into Table
insert_into_table() {
    if [[ -z $db_connection ]]; then
        echo "No database connected."
        return
    fi

    read -p "Enter table name: " table_name
    if [[ -f "$db_connection/$table_name" ]]; then
        read -p "Enter values (comma-separated): " values
        echo "$values" >> "$db_connection/$table_name"
        echo "Inserted values: $values"
    else
        echo "Table $table_name does not exist."
    fi
}

# Select From Table
select_from_table() {
    if [[ -z $db_connection ]]; then
        echo "No database connected."
        return
    fi

    read -p "Enter table name: " table_name
    if [[ -f "$db_connection/$table_name" ]]; then
        echo "Data from $table_name:"
        cat "$db_connection/$table_name"
    else
        echo "Table $table_name does not exist."
    fi
}

# Delete From Table
delete_from_table() {
    if [[ -z $db_connection ]]; then
        echo "No database connected."
        return
    fi

    read -p "Enter table name: " table_name
    if [[ -f "$db_connection/$table_name" ]]; then
        read -p "Enter row to delete (comma-separated values): " row
        sed -i "/^$row$/d" "$db_connection/$table_name"
        echo "Deleted row: $row"
    else
        echo "Table $table_name does not exist."
    fi
}

# Update Table
update_table() {
    if [[ -z $db_connection ]]; then
        echo "No database connected."
        return
    fi

    read -p "Enter table name: " table_name
    if [[ -f "$db_connection/$table_name" ]]; then
        read -p "Enter old row values (comma-separated): " old_row
        read -p "Enter new row values (comma-separated): " new_row
        sed -i "s/^$old_row\$/$new_row/" "$db_connection/$table_name"
        echo "Updated row from: $old_row to: $new_row"
    else
        echo "Table $table_name does not exist."
    fi
}

# Main Menu
while true; do
    echo "Bash Shell Script DBMS"
    echo "1. Create Database"
    echo "2. List Databases"
    echo "3. Connect To Database"
    echo "4. Drop Database"
    echo "5. Create Table"
    echo "6. List Tables"
    echo "7. Drop Table"
    echo "8. Insert into Table"
    echo "9. Select From Table"
    echo "10. Delete From Table"
    echo "11. Update Table"
    echo "12. Exit"
    read -p "Choose an option: " option

    case $option in
        1) create_database ;;
        2) list_databases ;;
        3) connect_database ;;
        4) drop_database ;;
        5) create_table ;;
        6) list_tables ;;
        7) drop_table ;;
        8) insert_into_table ;;
        9) select_from_table ;;
        10) delete_from_table ;;
        11) update_table ;;
        12) exit 0 ;;
        *) echo "Invalid option" ;;
    esac
done

