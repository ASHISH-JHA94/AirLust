// userController.js

function formatDOB(dob) {
    const dateObj = new Date(dob);
    if (!isNaN(dateObj.getTime())) {
        const day = dateObj.getDate();
        const month = dateObj.toLocaleString('default', { month: 'short' });
        const year = dateObj.getFullYear().toString().slice(2);
        return `${day} ${month} ${year}`;
    }
    return dob;
}

module.exports = {
    formatDOB,
};
