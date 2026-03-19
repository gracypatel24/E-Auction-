</div> <!-- Close content-area -->
        
        <!-- Footer -->
        <div class="footer">
            &copy; 2026 E-Auction. All rights reserved. | Admin Panel v1.0
        </div>
    </div> <!-- Close main-content -->

    <script>
        function toggleDropdown() {
            document.getElementById('dropdownMenu').classList.toggle('show');
        }
        
        // Close dropdown when clicking outside
        window.onclick = function(event) {
            if (!event.target.matches('.user-profile') && !event.target.matches('.user-profile *')) {
                var dropdowns = document.getElementsByClassName('dropdown-menu');
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>
</body>
</html>