

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

function getSeat(seat_number){
    let seat_offset_tag=seat_number%6;
    let seat_codes=['A','B','C','D','E','F'];
    let seat_string="";
    if (seat_offset_tag!=0){
        seat_string+=String(parseInt(seat_number/6))+String(seat_codes[seat_offset_tag-1]);}
    else{
        seat_string+=String(parseInt(seat_number/6))+"F";
    }
    return seat_string;
}

module.exports = {
    formatDOB, getSeat
};
