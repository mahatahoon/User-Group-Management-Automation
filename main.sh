#!/bin/bash
PS3="Please select a number:" ; export PS3

function first_menu {
    select selection in Add_user Delete_user Modify_user Add_group Delete_group Change_GroupName Exit
    do 
        case $selection in 
            Add_user)
                read -p "Enter a USERNAME you want to add: " addUser
                if grep -q "^$addUser:" /etc/passwd
                then
                    echo "The user $addUser already exists"
                else
                    sudo useradd $addUser
                    echo "USER $addUser CREATED SUCCESSFULLY"    
                fi
                ;;
            Delete_user)
                read -p "Enter a USERNAME you want to delete: " delUser
                if grep -q "^$delUser:" /etc/passwd
                then
                    sudo userdel $delUser
                    echo "USER $delUser DELETED SUCCESSFULLY"
                else
                    echo "USER $delUser doesn't exist"
                fi
                ;;
            Modify_user)
                modify_user
                ;;
	    Add_group)
		    read -p "Enter a USERNAME you want to add: " addGroup
                if grep -q "^$addGroup:" /etc/group
                then
                    echo "The Group $addGroup already exists"
                else
                    sudo groupadd $addGroup
                    echo "Group $addGroup CREATED SUCCESSFULLY"
                fi
                ;;
	    Delete_group)
		    read -p "Enter a Group you want to delete: " delGroup
                if grep -q "^$delGroup:" /etc/group
                then
                    sudo userdel $delUser
                    echo "USER $delGroup DELETED SUCCESSFULLY"
                else
                    echo "Group $delGroup doesn't exist"
		fi
		;;
	    Change_GroupName)
		read -p "Enter the GroupNAME you want to modify: " modifyGroup
                read -p "Enter a new groupname: " newGroupName
                sudo groupmod -n "$newGroupName" "$modifyGroup"
                echo "Group name changed to $newGroupName successfully"
                
		;;
            Exit)
                break
                ;;
            *)
                echo "Invalid input, Please select a number from 1 to 4:"
                ;;
        esac
    done
}

function modify_user {
    select option in Change_Name Change_Password Add_To_Group Return_Back
    do 
        case $option in 
            Change_Name)
                read -p "Enter the USERNAME you want to modify: " modifyUser
                read -p "Enter a new username: " newName
                sudo usermod -l "$newName" "$modifyUser"
                echo "Username changed to $newName successfully"
                ;;
            Change_Password)
                read -p "Enter the USERNAME you want to modify: " modifyUser
                sudo passwd "$modifyUser"
                echo "Password of user $modifyUser changed successfully"
                ;;
            Add_To_Group)
                read -p "Enter the USERNAME you want to modify: " modifyUser
                read -p "Enter the group that you want to add the user to: " groupName
                if grep -q "^$groupName:" /etc/group
                then
                    sudo usermod -aG "$groupName" "$modifyUser"
                    echo "User added to group $groupName successfully"
                else
                    echo "Group $groupName doesn't exist"
                    read -p "Enter the group that you want to add the user to: " groupName
                    sudo usermod -aG "$groupName" "$modifyUser"
                    echo "User added to group $groupName successfully"
                fi
                ;;
            Return_Back)
		bash FinalTask.sh
		break                
                ;;
            *)
                echo "Invalid, Please choose the right option."
                ;;
        esac
    done
}

first_menu

