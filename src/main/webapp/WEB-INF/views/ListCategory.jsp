<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Category List - E-Auction</title>
    <link rel="shortcut icon" th:href="@{/assets/images/favicon.png}">
    <link rel="stylesheet" th:href="@{/assets/css/vertical-layout-light/style.css}">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@mdi/font@6.5.95/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container-scroller">

    <!-- NAVBAR -->
    <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex align-items-top flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center align-items-lg-start">
            <a class="navbar-brand brand-logo" th:href="@{/admin-dashboard}">
                <img th:src="@{/assets/images/logo.svg}" alt="Logo">
            </a>
            <a class="navbar-brand brand-logo-mini" th:href="@{/admin-dashboard}">
                <img th:src="@{/assets/images/logo-mini.svg}" alt="Logo">
            </a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-top">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link" href="#" data-bs-toggle="dropdown">
                        <img class="img-xs rounded-circle" th:src="@{/assets/images/faces/face8.jpg}" alt="Profile">
                    </a>
                    <div class="dropdown-menu dropdown-menu-end navbar-dropdown">
                        <a class="dropdown-item" th:href="@{/logout}">
                            <i class="dropdown-item-icon mdi mdi-power"></i> Sign Out
                        </a>
                    </div>
                </li>
            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-bs-toggle="offcanvas">
                <span class="mdi mdi-menu"></span>
            </button>
        </div>
    </nav>
    <!-- END NAVBAR -->

    <div class="container-fluid page-body-wrapper">

        <!-- SIDEBAR -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
            <ul class="nav">
                <li class="nav-item nav-category"><span class="nav-link">Main Menu</span></li>
                <li class="nav-item menu-items">
                    <a class="nav-link" th:href="@{/admin-dashboard}">
                        <span class="menu-icon"><i class="mdi mdi-speedometer"></i></span>
                        <span class="menu-title">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item menu-items active">
                    <a class="nav-link" data-bs-toggle="collapse" href="#categoryMenu" aria-expanded="true">
                        <span class="menu-icon"><i class="mdi mdi-tag-multiple"></i></span>
                        <span class="menu-title">Category</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse show" id="categoryMenu">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" th:href="@{/newCategory}">New Category</a></li>
                            <li class="nav-item"><a class="nav-link active" th:href="@{/listCategory}">List Category</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item menu-items">
                    <a class="nav-link" th:href="@{/newUserType}">
                        <span class="menu-icon"><i class="mdi mdi-account-box-outline"></i></span>
                        <span class="menu-title">User Type</span>
                    </a>
                </li>
                <li class="nav-item menu-items">
                    <a class="nav-link" href="#">
                        <span class="menu-icon"><i class="mdi mdi-account-group"></i></span>
                        <span class="menu-title">Users</span>
                    </a>
                </li>
                <li class="nav-item nav-category"><span class="nav-link">Account</span></li>
                <li class="nav-item menu-items">
                    <a class="nav-link" th:href="@{/logout}">
                        <span class="menu-icon"><i class="mdi mdi-logout"></i></span>
                        <span class="menu-title">Logout</span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- END SIDEBAR -->

        <!-- MAIN CONTENT -->
        <div class="main-panel">
            <div class="content-wrapper">

                <div class="row">
                    <div class="col-12 d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h3 class="font-weight-bold">Category List</h3>
                            <p class="text-muted mb-0">All auction categories</p>
                        </div>
                        <a th:href="@{/newCategory}" class="btn btn-primary">
                            <i class="mdi mdi-plus me-1"></i> Add Category
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <!-- categoryList comes from CategoryController: model.addAttribute("categoryList", ...) -->
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Category Name</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <!-- Show message if no categories -->
                                        <tr th:if="${#lists.isEmpty(categoryList)}">
                                            <td colspan="4" class="text-center text-muted">No categories found</td>
                                        </tr>

                                        <!-- Loop through categories -->
                                        <tr th:each="cat, i : ${categoryList}">
                                            <td th:text="${i.index + 1}">1</td>
                                            <td th:text="${cat.categoryName}">Category</td>
                                            <td>
                                                <label th:if="${cat.active}" class="badge badge-success">Active</label>
                                                <label th:unless="${cat.active}" class="badge badge-danger">Inactive</label>
                                            </td>
                                            <td>
                                                <a th:href="@{/editCategory(id=${cat.categoryId})}"
                                                   class="btn btn-sm btn-warning me-1">Edit</a>
                                                <form th:action="@{/deleteCategory}" method="post" style="display:inline"
                                                      onsubmit="return confirm('Delete this category?')">
                                                    <input type="hidden" name="id" th:value="${cat.categoryId}">
                                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                                </form>
                                            </td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <footer class="footer">
                <div class="d-sm-flex justify-content-center">
                    <span class="text-muted d-block d-sm-inline-block">E-Auction Admin Panel &copy; 2026</span>
                </div>
            </footer>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script th:src="@{/assets/js/template.js}"></script>
<script th:src="@{/assets/js/off-canvas.js}"></script>
<script th:src="@{/assets/js/hoverable-collapse.js}"></script>
<script th:src="@{/assets/js/settings.js}"></script>
</body>
</html>