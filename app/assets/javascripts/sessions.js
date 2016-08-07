$(function() {

    var surprises = $(".surprises");
    var surpriseIndex = -1;

    function showNextSurprise() {
        ++surpriseIndex;
        surprises.eq(surpriseIndex % surprises.length)
            .fadeIn(1000)
            .delay(1000)
            .fadeOut(1000, showNextSurprise);
    }

    showNextSurprise();

});
