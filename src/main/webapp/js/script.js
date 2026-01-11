// JavaScript for Pharmacy Information System

// Form validation
document.addEventListener('DOMContentLoaded', function() {
    // Add custom form validation styles
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });

    // Auto-dismiss alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        if (alert.classList.contains('alert-success')) {
            setTimeout(() => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            }, 5000);
        }
    });
});

// Confirm delete action
function confirmDelete(message) {
    return confirm(message || '정말 삭제하시겠습니까?');
}

// Search form enhancement
document.addEventListener('DOMContentLoaded', function() {
    const searchType = document.getElementById('searchType');
    const keyword = document.getElementById('keyword');
    
    if (searchType && keyword) {
        searchType.addEventListener('change', function() {
            keyword.focus();
        });
    }
});
