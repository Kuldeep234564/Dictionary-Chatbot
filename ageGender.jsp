<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ageGender</title>
<link rel="stylesheet" href="ageGender.css">
<script>
    function setDOBRange() {
        const ageInput = document.querySelector("input[name='age']");
        const dobInput = document.querySelector("input[name='dob']");
        const errorMessage = document.getElementById("error-message");

        // Get the entered age
        const age = parseInt(ageInput.value);
        if (!isNaN(age) && age > 0) {
            const today = new Date();

            // Calculate maximum and minimum DOB
            const maxDOB = new Date();
            maxDOB.setFullYear(today.getFullYear() - age); // Current year minus entered age

            const minDOB = new Date();
            minDOB.setFullYear(today.getFullYear() - age - 1); // One year before the max year
            minDOB.setDate(minDOB.getDate() + 1); // Add one day to ensure the range is correct

            // Format the dates to YYYY-MM-DD
            dobInput.max = maxDOB.toISOString().split('T')[0];
            dobInput.min = minDOB.toISOString().split('T')[0];

            // Reset the DOB field and hide error
            dobInput.value = '';
            errorMessage.textContent = '';
        }
    }

    function validateDOB() {
        const dobInput = document.querySelector("input[name='dob']");
        const errorMessage = document.getElementById("error-message");

        const enteredDOB = new Date(dobInput.value);
        const minDOB = new Date(dobInput.min);
        const maxDOB = new Date(dobInput.max);

        // Check if DOB is within the valid range
        if (enteredDOB < minDOB || enteredDOB > maxDOB) {
            errorMessage.textContent = "The date of birth must match the entered age.";
            return false;
        }

        errorMessage.textContent = '';
        return true;
    }
</script>
</head>
<body>
<div class="container">
    <form action="UserDetailsServlet" method="post" onsubmit="return validateDOB()">
        <label>Age</label><input type="number" name="age" required oninput="setDOBRange()"><br>
        <label>Gender</label>
        <select name="gender">
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select><br>
        <label>Date Of Birth</label>
        <input type="date" name="dob" required><br>
        <div id="error-message" style="color: red; font-size: 0.9em;"></div>
        <input type="hidden" name="step" value="2">
        <button type="submit">Next</button>
    </form>
</div>
</body>
</html>
