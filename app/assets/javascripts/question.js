$(document).on('turbolinks:load', function(){
    const updateQuestions = () => {
        $('.question').on('click', '.edit-question-link', (e) => {
            e.preventDefault();
            $(e.currentTarget).hide()
            $('form#edit-question').removeClass('hidden');
        })
    }
    window.updateQuestions = updateQuestions
    updateQuestions()
});