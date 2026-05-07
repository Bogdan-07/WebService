<?php
$pdo = new PDO("mysql:host=localhost;dbname=coworking_db", "root", "");

if (isset($_GET['book'])) {
    $id = $_GET['book'];
    $stmt = $pdo->prepare("UPDATE desks SET disponibile = 0 WHERE id = ?");
    $stmt->execute([$id]);
    header("Location: index.php");
}
$desks = $pdo->query("SELECT * FROM desks")->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <title>SmartDesk Coworking</title>
    <style>
        body { font-family: sans-serif; background: #f4f4f4; padding: 20px; }
        .grid { display: flex; gap: 10px; }
        .card { background: white; padding: 15px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); width: 150px; text-align: center; }
        .status { font-weight: bold; }
        .free { color: green; }
        .busy { color: red; }
        .btn { display: inline-block; margin-top: 10px; padding: 5px 10px; background: #2471a3; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>Prenotazione Postazioni Coworking</h1>
    <div class="grid">
        <?php foreach ($desks as $d): ?>
        <div class="card">
            <h3>Postazione <?php echo $d['codice']; ?></h3>
            <p class="status <?php echo $d['disponibile'] ? 'free' : 'busy'; ?>">
                <?php echo $d['disponibile'] ? 'DISPONIBILE' : 'OCCUPATA'; ?>
            </p>
            <?php if ($d['disponibile']): ?>
                <a href="?book=<?php echo $d['id']; ?>" class="btn">Prenota</a>
            <?php endif; ?>
        </div>
        <?php endforeach; ?>
    </div>
    <p><br>Accedi al Web Service JSON: <a href="api.php">api.php</a></p>
</body>
</html>
