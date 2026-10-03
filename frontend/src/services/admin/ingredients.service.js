export async function getIngredientsCount() {
    const response = await fetch("/api/admin/ingredients/count");

    if (!response.ok) {
        throw new Error(`HTTP error: ${response.status}`);
    }

    return response.json();
}