<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-lg-6 col-md-8 col-sm-12">

				<div class="card shadow">
					<div class="card-header bg-primary text-white text-center">
						<h4>User Registration</h4>
					</div>

					<div class="card-body">

						<!-- BUG #13 FIX: Success / error flash messages -->
						<c:if test="${not empty successMsg}">
							<div class="alert alert-success alert-dismissible fade show" role="alert">
								<c:out value="${successMsg}"/>
								<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
							</div>
						</c:if>
						<c:if test="${not empty errorMsg}">
							<div class="alert alert-danger alert-dismissible fade show" role="alert">
								<c:out value="${errorMsg}"/>
								<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
							</div>
						</c:if>

						<form action="register" method="post" enctype="multipart/form-data">

							<!-- CSRF token (Spring Security) -->
							<!-- BUG #3 FIX: CSRF protection -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

							<!-- First Name -->
							<!-- BUG #8 FIX: Added 'for' + 'id' on every label/input pair -->
							<div class="mb-3">
								<label class="form-label" for="firstName">First Name</label>
								<input type="text" id="firstName" name="firstName"
									class="form-control" required>
							</div>

							<!-- Last Name -->
							<div class="mb-3">
								<label class="form-label" for="lastName">Last Name</label>
								<input type="text" id="lastName" name="lastName"
									class="form-control" required>
							</div>

							<!-- Email -->
							<div class="mb-3">
								<label class="form-label" for="email">Email</label>
								<input type="email" id="email" name="email"
									class="form-control" required>
							</div>

							<!-- Password -->
							<!-- BUG #6 FIX: Added minlength="8" and maxlength="64" -->
							<div class="mb-3">
								<label class="form-label" for="password">Password</label>
								<input type="password" id="password" name="password"
									class="form-control" minlength="8" maxlength="64" required
									title="Password must be at least 8 characters">
							</div>

							<!-- Confirm Password -->
							<!-- BUG #7 FIX: Added confirm password field -->
							<div class="mb-3">
								<label class="form-label" for="confirmPassword">Confirm Password</label>
								<input type="password" id="confirmPassword" name="confirmPassword"
									class="form-control" minlength="8" maxlength="64" required
									title="Re-enter your password">
								<div id="passwordMismatchMsg" class="text-danger small mt-1" style="display:none;">
									Passwords do not match.
								</div>
							</div>

							<!-- Gender -->
							<div class="mb-3">
								<label class="form-label d-block">Gender</label>
								<div class="form-check form-check-inline">
									<!-- BUG #8 FIX: Added id + for on radio labels -->
									<input class="form-check-input" type="radio" id="genderMale"
										name="gender" value="MALE" required>
									<label class="form-check-label" for="genderMale">Male</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" id="genderFemale"
										name="gender" value="FEMALE">
									<label class="form-check-label" for="genderFemale">Female</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" id="genderOther"
										name="gender" value="OTHER">
									<label class="form-check-label" for="genderOther">Other</label>
								</div>
							</div>

							<!-- Birth Year -->
							<!-- BUG #4 FIX: max changed from 2100 to 2006 (ensures user is at least 18) -->
							<div class="mb-3">
								<label class="form-label" for="birthYear">Birth Year</label>
								<input type="number" id="birthYear" name="birthYear"
									class="form-control" min="1900" max="2006" required
									title="Year must be between 1900 and 2006">
							</div>

							<!-- Contact Number -->
							<!-- BUG #5 FIX: Changed to type="tel" with numeric pattern validation -->
							<div class="mb-3">
								<label class="form-label" for="contactNum">Contact Number</label>
								<input type="tel" id="contactNum" name="contactNum"
									class="form-control" pattern="[0-9]{10,15}"
									title="Enter a valid phone number (10–15 digits)" required>
							</div>

							<!-- Qualification -->
							<div class="mb-3">
								<label class="form-label" for="qualification">Qualification</label>
								<input type="text" id="qualification" name="qualification"
									class="form-control" placeholder="e.g. B.Tech, MCA, BSc" required>
							</div>

							<!-- City -->
							<div class="mb-3">
								<label class="form-label" for="city">City</label>
								<input type="text" id="city" name="city"
									class="form-control" placeholder="Enter city" required>
							</div>

							<!-- State -->
							<div class="mb-3">
								<label class="form-label" for="state">State</label>
								<input type="text" id="state" name="state"
									class="form-control" placeholder="Enter state" required>
							</div>

							<!-- Country -->
							<div class="mb-3">
								<label class="form-label" for="country">Country</label>
								<input type="text" id="country" name="country"
									class="form-control" placeholder="Enter country"
									value="India" required>
							</div>

							<!-- Profile Picture -->
							
							<div class="mb-3">
								<label class="form-label" for="profilePic">Profile Picture</label>
								<input type="file" id="profilePic" name="profilePic"
									class="form-control" accept="image/*">
							</div>

							<!-- Submit -->
							<div class="d-grid">
								<button type="submit" class="btn btn-success">Save User</button>
							</div>

						</form>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<%-- BUG #7 FIX: Client-side confirm-password validation --%>
	<script>
		(function () {
			var form       = document.querySelector('form');
			var pwdField   = document.getElementById('password');
			var cpwdField  = document.getElementById('confirmPassword');
			var mismatchEl = document.getElementById('passwordMismatchMsg');

			function validatePasswords() {
				if (cpwdField.value && pwdField.value !== cpwdField.value) {
					mismatchEl.style.display = 'block';
					cpwdField.setCustomValidity('Passwords do not match.');
				} else {
					mismatchEl.style.display = 'none';
					cpwdField.setCustomValidity('');
				}
			}

			pwdField.addEventListener('input', validatePasswords);
			cpwdField.addEventListener('input', validatePasswords);

			form.addEventListener('submit', function (e) {
				validatePasswords();
				if (!form.checkValidity()) {
					e.preventDefault();
					form.reportValidity();
				}
			});
		})();
	</script>

</body>
</html>
