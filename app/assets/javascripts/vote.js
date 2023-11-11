$(document).on('turbolinks:load', function(){
    $('.rating').on('ajax:success', displayRating)
            .on('page:update', displayRating)
            .on('ajax:error', displayErrors)
})

function displayRating(event) {
    let resourceId = event.detail[0].resource_id
    let status = event.detail[0].status
    if (status === 'unprocessable_entity') {
        displayErrors(event)
    } else {
        let resourceName = event.detail[0].resource_name
        let rating = event.detail[0].rating
        let ratedBefore = event.detail[0].voted_before
        let ratingTagName = '#' + resourceName + '-id-' + resourceId + '-rating'
        $(ratingTagName + '> .vote > .vote-value').html(rating)

        if (ratedBefore) {
            console.log(ratedBefore)
            $(ratingTagName + '> .vote > .cancel').removeClass('hidden')
            $(ratingTagName + '> .vote > .up').addClass('hidden')
            $(ratingTagName + '> .vote > .down').addClass('hidden')
        } else {console.log(ratedBefore)
            $(ratingTagName + '> .vote > .cancel').addClass('hidden')
            $(ratingTagName + '> .vote > .up').removeClass('hidden')
            $(ratingTagName + '> .vote > .down').removeClass('hidden')
        }
    }
}

function displayErrors(event) {
    let errors = event.detail[0].error
    let errorsList = document.createElement('ul')
    console.log('.errors-'+event.detail[0].resource_name+'-vote')
    $('.errors-'+event.detail[0].resource_name+'-vote').html('').append(errorsList)
    if ($.isArray(errors)) {
        $.each(errors, function(index, value){
            let liElement = document.createElement('li')
            liElement.append(value)
            errorsList.append(liElement)
        })
    } else {
        let liElement = document.createElement('li')
        liElement.append(errors)
        errorsList.append(liElement)
        console.log(errors)
    }
}