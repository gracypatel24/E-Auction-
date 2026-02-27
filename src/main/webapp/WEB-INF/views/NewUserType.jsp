<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>New User Type - E-Auction</title>
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
                <li class="nav-item menu-items">
                    <a class="nav-link" data-bs-toggle="collapse" href="#categoryMenu" aria-expanded="false">
                        <span class="menu-icon"><i class="mdi mdi-tag-multiple"></i></span>
                        <span class="menu-title">Category</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="collapse" id="categoryMenu">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"><a class="nav-link" th:href="@{/newCategory}">New Category</a></li>
                            <li class="nav-item"><a class="nav-link" th:href="@{/listCategory}">List Category</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item menu-items active">
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
                    <div class="col-12">
                        <h3 class="font-weight-bold">Add New User Type</h3>
                        <p class="text-muted mb-4">Create a new user role/type</p>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">User Type Details</h4>

                                <!-- action="saveUserType" matches @PostMapping("saveUserType") in UserTypeController -->
                                <form action="saveUserType" method="post">
                                    <div class="form-group mb-3">
                                        <label class="form-label">User Type Name</label>
                                        <input type="text" name="userType" class="form-control"
                                               placeholder="e.g. ADMIN, PARTICIPANT, JUDGE" required>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="mdi mdi-check me-1"></i>Save User Type
                                        </button>
                                        <a th:href="@{/admin-dashboard}" class="btn btn-outline-secondary">
                                            Cancel
                                        </a>
                                    </div>
                                </form>

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