IFS=','
 head_banner() {
    clear
     echo "======================================================================================================================"
     echo "					Welcome to the Employee Management System"
     echo "======================================================================================================================"
}

#Admin banner
 admin_banner() {
    clear
     echo "======================================================================================================================"
     echo "					 	     ADMIN PANEL"
     echo "======================================================================================================================"
}

 admin_panel() {
    choice="y"
    while [ $choice == "y" ] || [ $choice == "Y" ]
    do
    	clear
        admin_banner
        echo "1. Add Employee"
        echo "2. Delete Employee"
        echo "3. View Employees"
        echo "4. Update Employee"
        echo "5. Search Employee"
        echo "6. LogOut"
        echo "7. Increment salary"
        echo "Enter your choice: "
        read admin_choice

        case "$admin_choice" in
            1)
                clear
                admin_banner
                add_employee
                ;;
            2)
                clear
                Deletion
                ;;
            3)
                clear
                display
                ;;
            4)
                Modification
                ;;
            5)
                clear
                search
                ;;
            
            6)
                admin_interface
                ;;
            7) 
               increment_salary
               ;;  
                
            *)
                echo "Invalid Input"
                ;;
        esac
        # Ask admin if they want to continue
        echo -e "\nDo you want to perform another operation [y/n]: "
        read choice
    done
}


 admin_login() {
    clear
    head_banner
    
    echo "Enter Admin ID:"
    read admin_id
    echo "Enter Password:"
    read -s admin_password

  flag=0
  while read id name pass
  do
  if [ "$id" == "$admin_id" ]  && [ "$pass" == "$admin_password" ]
  then
  flag=1  
  fi
  done < admin.csv
    if [ $flag -eq 1 ]
    then
        echo "Successfully logged in as Admin"
        admin_panel
    else
        echo "Incorrect Admin ID or Password"
      
	 admin_login
    fi
}

 admin_register() {
if [ ! -f admin.csv ]; then
    touch admin.csv
  fi  
    echo "Enter Admin Name:"
    read admin_name
    echo "Enter Admin ID:"
    read admin_id
    echo "Enter Password:"
    read -s admin_password

    # Check if admin ID already exists
    check=$(grep "$admin_id" admin.csv)

    if [ -z "$check" ]
    then
        echo "$admin_id,$admin_name,$admin_password" >> admin.csv
        echo "Admin registered successfully"

	admin_interface
    else
        echo "$admin_id already exists in the admin table"
	admin_register
    fi
}

# Function to handle admin interface
 admin_interface() {
    head_banner
    echo "1. Login"
    echo "2. Register"
    echo "3. Exit"
    echo "Enter your choice: "
    read admin_interface_choice

    case "$admin_interface_choice" in
        1)
            admin_login
            ;;
        2)
            admin_register
            ;;
        3)
            clear
            exit
            ;;
        *)
            echo "Invalid Input"
            clear
            admin_interface
            ;;
    esac
}

#Function to add employee
 add_employee() {
admin_banner

#if csv file not created
if [ ! -f employee.csv ]; then
    touch employee.csv
    #echo "ID, NAME, ADDRESS, DOB, SEX, DEPARTMENT, SALARY, DESIGNATION, JOINING DATE" > employee.csv
    

fi
    echo "                                                                                             "
    
    echo "					Employee Details"
    echo "                                      ================"
    
    echo "Enter Employee ID:"
    read employee_id
    echo "Enter Employee Name:"
    read employee_name
    echo "Enter Employee Address:"
    read address
    echo "Enter Employee Date of Birth D/M/Y:"
    read dob
    echo "Enter Employee Sex:"
    read employee_sex
    echo "Enter Department:"
    read department
    echo "Enter Employee Salary:"
    read salary
    echo "Enter Employee Designation:"
    read designation
    echo "Enter Employee Joining Date in D/M/Y:"
    read join_date
    
    

# Check if employee ID already exists or not
    check=$(grep "$employee_id" employee.csv)

    if [ -z "$check" ]
    then
        
        echo $employee_id,$employee_name,$address,$dob,$employee_sex,$department,$salary,$designation,$join_date >> employee.csv
        echo "Employee record successfully added"
        
        echo "enter 'r' to go back"
        while read -n 1 -s key
        do
  		if [ "$key" == "r" ]  || [ "$key" == "R" ]
 	 	then
  	 	     admin_panel
  		fi
  		echo " you pressed invalid key."
        done

	
    else
        echo "$employee_id already exists in the employees record"
        
        echo "Do you want to continue [y/n]: "
        while read -n 1 -s choice
        do
        	if [ "$choice" == "y" ]
        	then
             	    clear
             	    add_employee
       		fi
	        if [ "$choice" == "n" ]
		then
	 	    admin_panel
		fi
		echo "you pressed invalid key."
	done
    fi
}

# header function to show employee details

 header(){
    echo -e "\n-------------\t---------\t-------\t-------------\t---\t----------\t------\t-----------\t------------\n"
    echo -e "Emp_ID\t\tEMP_Name\tAddress\tDate_Of_Birth\tSex\tDepartment\tSalary\tDesignation\tJoining_Date\n"
    echo -e "\n-------------\t---------\t-------\t-------------\t---\t----------\t------\t-----------\t------------\n"
}

#Search function
 search() {
    admin_banner

    echo "1. Search Employee by Name"
    echo "2. Search employee by Id"
    echo "3. Back"
    echo "Enter your choice: "
    read choice

    case "$choice" in
        1)
            clear
            admin_banner
            echo "Enter the Employee name: "
            read employee_name

            # Search by employee name
            search_result=$(awk -v name="$employee_name" -F',' '$2 == name {printf "%-15s%-18s%-8s%-13s%-10s%-15s%-10s%-10s%-10s\n", $1, $2, $3, $4, $5, $6, $7, $8,$9}' employee.csv)

            if [ -n "$search_result" ]; then
                echo -e "\n\n\n\nSearch Results:"
                header  
                echo "$search_result"
            else
                echo "No records found for the given name: $employee_name"
            fi
            echo -e "\n\n\n\nPress any key to go back..."
            read -n 1 -s key
            admin_panel
            ;;
        2)
            clear
            admin_banner
            echo "Enter the Employee ID: "
            read employee_id

            # Search by employee id
           search_result=$(awk -v id="$employee_id" -F',' '$1 == id {printf "%-15s%-18s%-8s%-13s%-10s%-15s%-10s%-10s%-10s\n", $1, $2, $3, $4, $5, $6, $7, $8,$9}' employee.csv)

            if [ -n "$search_result" ]; then
                echo -e "\n\n\n\nSearch Results:"
                header 
                echo "$search_result" 
            else
                echo "No records found for the given ID: $employee_id"
            fi

            echo -e "\n\n\n\nPress any key to go back..."
            read -n 1 -s key
            admin_panel
            ;;
        
        3)
            clear
            admin_panel
            ;;
        *)
            echo "Invalid Input"
            clear
            admin_panel
            ;;
    esac
}

#DEletion for employee record
 Deletion() {
    admin_banner

    echo -e "\nEnter Employee ID whose record you want to delete: "
    read employee_id

    # Search for the employee ID in the CSV file
    search_result=$(awk -v id="$employee_id" -F',' '$1 == id' employee.csv)

    if [ -n "$search_result" ]; then
        echo -e "\n\n\n Before Deletion employees record"
        header
        awk 'BEGIN { FS = ","; OFS = "  \t" } { print $1, $2, $3, $4, $5, $6, $7, $8, $9}' employee.csv

        # Remove the line containing the employee ID from the CSV file
        sed -i "/^$employee_id,/d" employee.csv

        echo -e "Record with Employee ID $employee_id deleted successfully.\n\n\n\n"
        echo -e "\n\n\n After performing Deletion..."

        if [ ! -s employee.csv ]; then
            echo "No employees in the record."
            echo -e "\n\n\n\nPress any key to go back..."
            read -n 1 -s key
            clear
            admin_panel
        fi

        header
        awk 'BEGIN { FS = ","; OFS = "  \t" } { print $1, $2, $3, $4, $5, $6, $7, $8, $9}' employee.csv
    else
        echo "No records found for the given Employee ID: $employee_id"
    fi

    echo -e "\n\n\n\nPress any key to go back..."
    read -n 1 -s key
    clear
    admin_panel
}


# Display function to print existend employee in csv
 display() {
    admin_banner
    echo -e "\t1. Display details of all employees"
    echo -e "\t2. Display details of employees of a particular department"
    echo -e "\t3. Display details of employees whose salary in specific range"
    echo -e "\t4. Sort employee details in increasing order of salary"
    echo -e "\t5. Back"
    
    echo -e "\n\nEnter your choice: "
    read choice

    case "$choice" in
        1)
          display_all
            ;;
        2)
           department_display
            ;;
        3)
            clear
           range_display
            ;;
        4)
           clear
          
           sortedSalary
            
            ;;
        5)
            admin_panel
            ;;
        *)
            echo "Invalid Input"
            
            clear
            display
            ;;
    esac
}

#display all
 display_all() {
    clear
    admin_banner

    # Check if the CSV file exists
    if [ ! -f employee.csv ]; then
        echo "No employee records found."
        echo "Press any key to go back..."
        read -n 1 -s key
        clear
        display
    fi

    header

    awk 'BEGIN { FS = ","; OFS = "  \t" } { print $1, $2, $3, $4, $5, $6, $7, $8, $9}' employee.csv

    echo -e "\n\n\n\nPress any key to go back..."
    read -n 1 -s key
    clear

    display
}

#Display the employees of a specific department
 department_display() {
    clear
    admin_banner

    echo "Enter Department Name: "
    read dept_name

    if [ ! -f employee.csv ]; then
        echo "No employee records found."
        echo -e "\n\n\n\nPress any key to go back..."
        read -n 1 -s key
        clear
        display
    fi

    header

    #awk -v dept="$dept_name" -F',' '$6 == dept' employee.csv | column -s, -t
    awk -v dept="$dept_name" -F',' '$6 == dept {printf "%-15s%-18s%-8s%-13s%-10s%-15s%-10s%-10s%-10s\n", $1, $2, $3, $4, $5, $6, $7, $8,$9}' employee.csv


    echo -e "\n\n\n\nPress any key to go back..."
    read -n 1 -s key
    clear

    display
}

#Display employee with salary range
 range_display() {
    admin_banner

    echo "Enter Starting Salary: "
    read st
    echo "Enter Ending Salary: "
    read end
    if [ ! -f employee.csv ]; then
        echo "No employee records found."
        echo -e "\n\n\n\nPress any key to go back..."
        read -n 1 -s key
        clear
        display
    fi 
    header 

    # Filter and display employees within the salary range
    awk -v min="$st" -v max="$end" -F',' '$7 >= min && $7 <= max {printf "%-15s%-18s%-8s%-13s%-10s%-15s%-10s%-10s%-10s\n", $1, $2, $3, $4, $5, $6, $7, $8,$9}' employee.csv 

    echo -e "\n\n\n\nPress any key to go back..."
    read -n 1 -s key
    clear
    display
}


#sorted function
 
sortedSalary() {
    clear
    admin_banner
    if [ ! -s employee.csv ]; then
        echo "No records found!"
        echo -e "\nEnter any key to go back..."
        read -n 1 -s key
        clear
        display
    else
        header
        sort -t ',' -k 7 -n employee.csv | column -s ',' -t
        echo -e "\nEnter any key to go back..."
        read -n 1 -s key
        clear
        display
    fi
}



#modify existing record of employee
 Modification() {
    clear
    admin_banner

    echo "Enter Emp_ID of the employee whose record has to be modified: "
    read mod

    # Check if the employee record exists
    khojo=$(awk -v md="$mod" -F',' '$1 == md' employee.csv | wc -l)

    if [ "$khojo" -eq 0 ]; then
        printf "\n\n\n\t\t\t\tNO RECORDS FOUND TO MODIFY!\n\n\n"
    else
        echo "Old details: "
        echo "-------------"
        header
        awk -v md="$mod" -F',' '$1 == md {printf "%-15s%-18s%-8s%-13s%-10s%-15s%-10s%-10s%-10s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9}' employee.csv

        echo "Which field do you want to modify? Enter the field number: "
        read field

        echo -e "\n\n\n\nEnter new detail: "
        read nw

        # Perform modification and update the CSV
        awk -v f="$field" -v m="$mod" -v dibo="$nw" -F',' 'BEGIN {OFS=","} $1 == m {$f = dibo} {print}' employee.csv > tmp.csv && mv tmp.csv employee.csv

        echo -e "Record successfully modified.\n\n\n"
        echo "Updated details: "
        echo "----------------"
        header
        awk -v md="$mod" -F',' '$1 == md {printf "%-15s%-18s%-8s%-13s%-10s%-15s%-10s%-10s%-10s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9}' employee.csv
    fi

    echo -e "\n\n\n\nPress any key to go back..."
    read -n 1 -s key
    clear
    admin_panel
}

increment_salary() {
    current_date=$(date +%s) # Get the current date in seconds since epoch

    echo "Enter the increment percentage (e.g., 2 for 2%): "
    read increment_percentage

    temp_file="temp_employee.csv"
    touch "$temp_file"
    found_any=0

    while true
    IFS=',' read -r emp_id emp_name address dob sex department salary designation join_date; 
    do
        join_date_in_seconds=$(date -d "$join_date" +%s) 
        job_tenure=$(( (current_date - join_date_in_seconds) / (60*60*24*365) )) 

       
        if [ "$job_tenure" -gt 1 ]; then
          
            increment_amount=$(( (salary * increment_percentage) / 100 ))
           
            new_salary=$(( salary + increment_amount ))

            echo "$emp_id,$emp_name,$address,$dob,$sex,$department,$new_salary,$designation,$join_date" >> "$temp_file"
            found_any=1
        else
            
            echo "$emp_id,$emp_name,$address,$dob,$sex,$department,$salary,$designation,$join_date" >> "$temp_file"
        fi
    done < employee.csv

    if [ $found_any -eq 0 ]; then
        echo "No employee found with more than one year job tenure."
        rm "$temp_file" 
    else
        mv "$temp_file" employee.csv
        echo "Salary increment applied and updated in the records."
    fi
}




# Main program execution starts here
admin_interface
