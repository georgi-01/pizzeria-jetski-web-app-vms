export async function getEmployeesCount() {
    const response = await fetch("/api/admin/employees/count");

    if (!response.ok) {
        throw new Error(`HTTP error: ${response.status}`);
    }

    return response.json();
}