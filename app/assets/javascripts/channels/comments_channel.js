$(document).on('turbolinks:load', function(){
    App.cable.subscriptions.create({ channel: 'CommentsChannel', question_id: gon.question_id }, {
        connected() {
            console.log('Client connected to comments channel')
            console.log(gon.question_id)
            this.perform('follow');
        },

        disconnected() {
            console.log('Client disconnected from comments channel')
        },

        received(content) {
            console.log('received')
            console.log(content)
            if (gon.user_id !== content.comment.user_id) {
                let commentClass = content.comment.commentable_type + '-id-' + content.comment.commentable_id + '-comments'
                console.log(commentClass)
                $('.' + commentClass).append(JST["templates/comments"]({
                    comment: content.comment,
                    author: content.user
                }));
            } else {
                console.log('Comment already on page')
            }
        },

        follow: function() {
            return this.perform('follow');
        }
    })
})