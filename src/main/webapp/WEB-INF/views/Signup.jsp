<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<form action="register" method="post">

							<!-- First Name -->
							<div class="mb-3">
								<label class="form-label">First Name</label> <input type="text"
									name="firstName" class="form-control" required>
							</div>

							<!-- Last Name -->
							<div class="mb-3">
								<label class="form-label">Last Name</label> <input type="text"
									name="lastName" class="form-control" required>
							</div>

							<!-- Email -->
							<div class="mb-3">
								<label class="form-label">Email</label> <input type="email"
									name="email" class="form-control" required>
							</div>

							<!-- Password -->
							<div class="mb-3">
								<label class="form-label">Password</label> <input
									type="password" name="password" class="form-control" required>
							</div>

							<!-- Gender -->
							<div class="mb-3">
								<label class="form-label d-block">Gender</label>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="gender"
										value="MALE" required> <label class="form-check-label">Male</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="gender"
										value="FEMALE"> <label class="form-check-label">Female</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="gender"
										value="OTHER"> <label class="form-check-label">Other</label>
								</div>
							</div>

							<!-- Birth Year -->
							<div class="mb-3">
								<label class="form-label">Birth Year</label> <input
									type="number" name="birthYear" class="form-control" min="1900"
									max="2100" required>
							</div>

							<!-- Contact Number -->
							<div class="mb-3">
								<label class="form-label">Contact Number</label> <input
									type="text" name="contactNum" class="form-control" required>
							</div>


							<!-- Qualification -->
							<div class="mb-3">
								<label class="form-label">Qualification</label> <input
									type="text" name="qualification" class="form-control"
									placeholder="e.g. B.Tech, MCA, BSc" required>
							</div>

							<!-- City -->
							<div class="mb-3">
								<label class="form-label">City</label> <input type="text"
									name="city" class="form-control" placeholder="Enter city"
									required>
							</div>

							<!-- State -->
							<div class="mb-3">
								<label class="form-label">State</label> <input type="text"
									name="state" class="form-control" placeholder="Enter state"
									required>
							</div>

							<!-- Country -->
							<div class="mb-3">
								<label class="form-label">Country</label> <input type="text"
									name="country" class="form-control" placeholder="Enter country"
									value="India" required>
							</div>


							<!-- Profile Pic URL -->
							<div class="mb-3">
								<label class="form-label">Profile Picture URL</label> <input
									type="file" name="profilePicURL" class="form-control">
							</div>


							<!-- Submit -->
							<div class="d-grid">
								<button type="submit" class="btn btn-success">Save User
								</button>
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

</body>
</html>