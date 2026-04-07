const express = require('express');
const app = express();
const mysql = require('mysql2');

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'recipal_db'
});

db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err.message);
        return;
    }
    console.log('Connected to the MySQL database!');
});

app.use(express.urlencoded({ extended: true }));
app.set('view engine', 'ejs');
app.use(express.static('public'));

app.get('/', (req, res) => {
    const sql = 'SELECT * FROM recipes ORDER BY RAND() LIMIT 1';
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.render('home', { featured: null });
        }
        res.render('home', { featured: results[0] });
    });
});

app.get('/recipes', (req, res) => {
    const sql = 'SELECT * FROM recipes';
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.render('recipes', { recipes: results });
    });
});

app.get('/recipe/:id', (req, res) => {
    const recipeId = req.params.id;
    
    const sql = `
        SELECT r.*, i.name AS ingredient_name, i.info AS ingredient_info 
        FROM recipes r
        LEFT JOIN recipe_ingredients ri ON r.id = ri.recipe_id
        LEFT JOIN ingredients i ON ri.ingredient_id = i.id
        WHERE r.id = ?`;

    db.query(sql, [recipeId], (err, results) => {
        if (err) throw err;
        if (results.length === 0) return res.status(404).send('Recipe not found');

        const recipe = {
            id: results[0].id,
            title: results[0].title,
            protein_type: results[0].protein_type,
            instructions: results[0].instructions,
            ingredients: results.map(row => ({
                name: row.ingredient_name,
                info: row.ingredient_info
            }))
        };
        res.render('recipe-detail', { recipe });
    });
});


app.get('/add-recipe', (req, res) => {
    db.query('SELECT * FROM ingredients', (err, ingredients) => {
        if (err) throw err;
        res.render('add-recipe', { ingredients });
    });
});

app.post('/add-recipe', (req, res) => {
    const { title, protein_type, instructions, ingredient_ids } = req.body;
    const sqlRecipe = 'INSERT INTO recipes (title, protein_type, instructions) VALUES (?, ?, ?)';
    
    db.query(sqlRecipe, [title, protein_type, instructions], (err, result) => {
        if (err) throw err;
        const newRecipeId = result.insertId;

        if (ingredient_ids && ingredient_ids.length > 0) {
            const values = ingredient_ids.map(ingId => [newRecipeId, ingId]);
            const sqlJunction = 'INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES ?';
            db.query(sqlJunction, [values], (err) => {
                if (err) throw err;
                res.redirect('/recipes');
            });
        } else {
            res.redirect('/recipes');
        }
    });
});

app.get('/recipe/:id', (req, res) => {
    const recipeId = req.params.id;
    const sql = `
        SELECT r.*, i.name AS ing_name, i.info AS ing_info 
        FROM recipes r
        LEFT JOIN recipe_ingredients ri ON r.id = ri.recipe_id
        LEFT JOIN ingredients i ON ri.ingredient_id = i.id
        WHERE r.id = ?`;

    db.query(sql, [recipeId], (err, results) => {
        if (err) throw err;
        if (results.length === 0) return res.status(404).render('404');   
        const recipe = {
            id: results[0].id,
            title: results[0].title,
            protein_type: results[0].protein_type,
            instructions: results[0].instructions,
            ingredients: results.map(row => ({ 
                name: row.ing_name, 
                info: row.ing_info 
            }))
        };
        res.render('recipe-detail', { recipe });
    });
});

app.get('/add-recipe', (req, res) => {
    db.query('SELECT * FROM ingredients', (err, results) => {
        if (err) throw err;
        res.render('add-recipe', { ingredients: results });
    });
});

app.post('/add-recipe', (req, res) => {
    const { title, protein_type, instructions, ingredient_ids } = req.body;

    const sqlRecipe = 'INSERT INTO recipes (title, protein_type, instructions) VALUES (?, ?, ?)';
    db.query(sqlRecipe, [title, protein_type, instructions], (err, result) => {
        if (err) throw err;  
        const newRecipeId = result.insertId;

        if (ingredient_ids) {
            const ids = Array.isArray(ingredient_ids) ? ingredient_ids : [ingredient_ids];    
            const values = ids.map(ingId => [newRecipeId, ingId]);
            const sqlJunction = 'INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES ?';
            
            db.query(sqlJunction, [values], (err) => {
                if (err) throw err;
                res.redirect('/recipes');
            });
        } else {
            res.redirect('/recipes');
        }
    });
});

//extra feature: delete a recipe
app.post('/recipe/:id/delete', (req, res) => {
    const recipeId = req.params.id;
    const sql = 'DELETE FROM recipes WHERE id = ?';

    db.query(sql, [recipeId], (err, result) => {
        if (err) {
            console.error("Error deleting recipe:", err);
            return res.status(500).send("Database error occurred while deleting.");
        }
        res.redirect('/recipes');
    });
});


app.listen(3000, () => console.log('Server running on http://localhost:3000'));
