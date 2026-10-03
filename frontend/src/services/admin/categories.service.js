export async function getCategoriesCount() {
    const response = await fetch("/api/admin/categories/count");

    if (!response.ok) {
        throw new Error(`HTTP error: ${response.status}`);
    }

    return response.json();
}