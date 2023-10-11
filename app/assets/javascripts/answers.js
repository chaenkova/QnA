$(document).on('turbolinks:load', function(){
    const updateAnswers = () => {
        $('.answers').on('click', '.edit-answer-link', (e) => {
            e.preventDefault();
            $(e.currentTarget).hide();
            var answerId = $(e.currentTarget).data('answerId');
            $('form#edit-answer-' + answerId).removeClass('hidden');
        })
    }
    window.updateAnswers = updateAnswers
    updateAnswers()
});
