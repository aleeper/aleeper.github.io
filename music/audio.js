document.addEventListener('DOMContentLoaded', function () {
  var tracks = document.querySelectorAll('.jemdoc-audio');

  function pullTrailingCopy(track) {
    var panel = track.querySelector('.audio-panel');
    if (!panel) {
      return;
    }

    while (track.nextSibling) {
      track.insertBefore(track.nextSibling, panel);
    }
  }

  function closeTrack(track) {
    track.classList.remove('is-open');
    var panel = track.querySelector('.audio-panel');
    var audio = track.querySelector('audio');
    if (panel) {
      panel.hidden = true;
      panel.style.display = 'none';
    }
    if (audio) {
      audio.pause();
      audio.currentTime = 0;
    }
  }

  function openTrack(track) {
    track.classList.add('is-open');
    var panel = track.querySelector('.audio-panel');
    if (panel) {
      panel.hidden = false;
      panel.style.display = 'block';
    }
  }

  for (var i = 0; i < tracks.length; i++) {
    (function (track) {
      var toggle = track.querySelector('.audio-toggle');
      var panel = track.querySelector('.audio-panel');
      var audio = track.querySelector('audio');
      if (!toggle || !panel || !audio) {
        return;
      }

      pullTrailingCopy(track);
      closeTrack(track);

      toggle.addEventListener('click', function (event) {
        event.preventDefault();

        var opening = panel.style.display === 'none' || panel.hidden;

        for (var j = 0; j < tracks.length; j++) {
          if (tracks[j] !== track) {
            closeTrack(tracks[j]);
          }
        }

        if (opening) {
          openTrack(track);
        } else {
          closeTrack(track);
        }
      });
    })(tracks[i]);
  }
});
