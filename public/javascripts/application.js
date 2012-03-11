function displayAvailableChars(textarea) {
    var text_length = textarea.value.length;
    var available_length = 140 - text_length;
    var text = "";
    if(available_length < 0)
        text = "Too long content";
    else if(available_length == 0)
        text = "No more characters available";
    else if(available_length == 1)
        text = "1 character available";
    else
        text = available_length + " characters available.";
    var pElmt = document.getElementById("available_chars");
    pElmt.innerHTML = text;
}