mkdir DBMS 2>> ./error.log
clear
echo " -- Welcome To OUR DBMS --"
function mainMenu() {
  echo -e "\n\n+---------Main Menu-------------+"
  echo "| 1. Select DB                  |"
  echo "| 2. Create DB                  |"
  echo "| 3. Rename DB                  |"
  echo "| 4. Drop DB                    |"
  echo "| 5. Show DBs                   |"
  echo "| 6. Exit                       |"
  echo "+-------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1)  selectDB ;;
    2)  createDB ;;
    3)  renameDB ;;
    4)  dropDB ;;
    5)  ls ./DBMS ; mainMenu;;
    6) exit ;;
    *) echo " Wrong Choice " ; mainMenu;
  esac
}

function selectDB {
  echo -e "Enter Database Name: \c"
  read dbName
  cd ./DBMS/$dbName 2>>./error.log
  if [[ $? == 0 ]]; then
    echo "$dbName was Successfully Selected"
    tablesMenu
  else
    echo "Database $dbName wasn't found"
      mainMenu

  fi
}

function createDB {
  echo -e "Enter Database Name: \c"
  read dbName
  mkdir ./DBMS/$dbName
  if [[ $? == 0 ]]
  then
    echo "Database Created Successfully"
  else
    echo "Error Creating Database $dbName"
  fi
  mainMenu
}

function renameDB {
  echo -e "Enter Current Database Name: \c"
  read dbName
  echo -e "Enter New Database Name: \c"
  read newName
  mv ./DBMS/$dbName ./DBMS/$newName 2>>./error.log
  if [[ $? == 0 ]]; then
    echo "Database Renamed Successfully"
  else
    echo "Error Renaming Database"
  fi
  mainMenu
}

function dropDB {
  echo -e "Enter Database Name: \c"
  read dbName
  rm -r ./DBMS/$dbName 2>>./error.log
  if [[ $? == 0 ]]; then
    echo "Database Dropped Successfully"
  else
    echo "Database Not found"
  fi
  mainMenu
}

function tablesMenu {
  echo -e "\n\n+--------Tables Menu------------+"
  echo "| 1. Create New Table           |"
  echo "| 2. Insert Into Table          |"
  echo "| 3. Select From Table          |"
  echo "| 4. Update Table               |"
  echo "| 5. Delete From Table          |"
  echo "| 6. Drop Table                 |"
  echo "| 7. Back To Main Menu          |"
  echo "| 8. Exit                       |"
  echo "+-------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1)  createTable ;;
    2)  ;;
    3)  clear; selectMenu ;;
    4)  ;;
    5)  ;;
    6)  dropTable ;;
    7) clear; mainMenu ;;
    8) exit ;;
    *) echo " Wrong Choice " ; mainMenu;
  esac

}

function createTable {
  echo -e "Enter Table Name \c"
  read tableName
  echo -e "Enter Number of Columns \c"
  read colsNum
  re='^[0-9]+$'
  if [[ $colsNum =~ $re ]]
  then
    counter=1
    seperator="|"
    while [ $counter -le $colsNum ]
    do
    echo -e "Enter Name of Column Number $counter:\c"
    read colName
    temp=$temp$colName$seperator
    ((counter++))
    done
    touch $tableName 2>>./error.log
    echo -e $temp >> $tableName
    if [[ $? == 0 ]]
    then
      echo "Table Created Successfully"
      tablesMenu
    else
      echo "Error Creating Table $tableName"
      tablesMenu
    fi
  else
    echo "The Value you entered is not a valid number"
    createTable
  fi
  
}

function dropTable {
  echo -e "Enter Table Name: \c"
  read tName
  rm $tName 2>>./error.log
  if [[ $? == 0 ]]
  then
    echo "Table Dropped Successfully"
  else
    echo "Error Dropping Table $tName"
  fi
  tablesMenu
}

function selectMenu {
  echo -e "\n\n+---------------Select Menu--------------------+"
  echo "| 1. Select All Columns of a Table             |"
  echo "| 2. Select Specific Column from a Table       |"
  echo "| 3. Select From Table under condition         |"
  echo "| 4. Aggregate Function for a Specific Column  |"
  echo "| 5. Back To Main Menu                         |"
  echo "| 6. Exit                                      |"
  echo "+----------------------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1)  selectAll ;;
    2)  ;;
    3)  ;;
    4)  ;;
    5) clear; mainMenu ;;
    6) exit ;;
    *) echo " Wrong Choice " ; mainMenu;
  esac
}

function selectAll {
  echo -e "Enter Table Name: \c"
  read tName
  column -t -s '|' $tName 2>>./error.log
  if [[ $? != 0 ]]
  then
    echo "Error Displaying Table $tName"
  fi
  selectMenu
}

mainMenu
