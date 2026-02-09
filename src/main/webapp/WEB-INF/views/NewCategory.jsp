<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Category</title>

<jsp:include page="AdminCSS.jsp"></jsp:include>

<style>
body {
	background-color: #f8f9fa;
}

.card {
	margin-top: 80px;
	border-radius: 12px;
}
</style>
</head>

<body>
	<!-- header -->
	<jsp:include page="AdminHeader.jsp"></jsp:include>

	<!-- Sidebar -->
	<jsp:include page="AdminSidebar.jsp"></jsp:include>


	<div class="content">
		<div class="row justify-content-center">
			<div class="col-md-6 col-lg-5">
				<div class="card shadow">
					<div class="card-body p-4">
						<h4 class="text-center mb-4">Add New Category</h4>

						<form action="saveCategory" method="post">

							<!-- Category Name -->
							<div class="mb-3">
								<label class="form-label">Category Name</label> <input
									type="text" name="categoryName" class="form-control"
									placeholder="Enter category name" required>
							</div>

							<!-- Buttons -->
							<div class="d-grid gap-2">
								<button type="submit" class="btn btn-primary">Save
									Category</button>
								<a href="admin-dashboard" class="btn btn-secondary"> Cancel
								</a>
							</div>

						</form>

					</div>
				</div>
			</div>
		</div>


	</div>
	<jsp:include page="AdminFooter.jsp"></jsp:include>



</body>
</html>