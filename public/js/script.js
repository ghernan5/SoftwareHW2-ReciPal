const tooltip = document.createElement('div');

tooltip.id = 'tooltip';
tooltip.style.display = 'none';
tooltip.style.position = 'absolute';
tooltip.style.padding = '10px';
tooltip.style.background = '#4a3728';
tooltip.style.color = '#fff';
tooltip.style.borderRadius = '5px';
tooltip.style.fontSize = '0.85em';
tooltip.style.maxWidth = '200px';
tooltip.style.zIndex = '1000';
tooltip.style.pointerEvents = 'none';
document.body.appendChild(tooltip);

document.addEventListener('mouseover', (e) => {
    if (e.target.classList.contains('ingredient-item')) {
        const info = e.target.getAttribute('data-info');
        tooltip.textContent = info;
        tooltip.style.display = 'block';
    }
});

document.addEventListener('mousemove', (e) => {
    if (tooltip.style.display === 'block') {
        tooltip.style.left = (e.pageX + 10) + 'px';
        tooltip.style.top = (e.pageY + 10) + 'px';
    }
});

document.addEventListener('mouseout', (e) => {
    if (e.target.classList.contains('ingredient-item')) {
        tooltip.style.display = 'none';
    }
});

function filterRecipes() {
    const input = document.getElementById('recipeSearch');
    if (!input) return;
    
    const filter = input.value.toLowerCase();
    const rows = document.querySelectorAll('.recipe-row');

    rows.forEach(row => {
        const title = row.querySelector('.recipe-title').textContent.toLowerCase();
        row.style.display = title.includes(filter) ? "" : "none";
    });
}

//form validation
document.addEventListener('DOMContentLoaded', () => {
    const recipeForm = document.getElementById('recipeForm');

    if (recipeForm) {
        recipeForm.addEventListener('submit', (e) => {
            const title = document.getElementById('title').value;
            const instructions = document.getElementById('instructions').value;
            const ingredientSelect = document.querySelector('select[name="ingredient_ids"]');
            
            const selectedIngredients = Array.from(ingredientSelect.selectedOptions).length;

            if (title.trim().length < 3) {
                alert("Please give your recipe a proper title (at least 3 characters).");
                e.preventDefault();
            } else if (selectedIngredients === 0) {
                alert("Please select at least one ingredient from the list!");
                e.preventDefault();
            } else if (instructions.trim().length < 10) {
                alert("Please provide some more detailed cooking instructions.");
                e.preventDefault();
            }
        });
    }
});
