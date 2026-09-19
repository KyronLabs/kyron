import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';
  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
      'about': MessageLookupByLibrary.simpleMessage('Acerca de'),
      'addAnAnswer':
          MessageLookupByLibrary.simpleMessage('Añadir una respuesta'),
      'agreeAndContinue': MessageLookupByLibrary.simpleMessage(
        'Aceptar y continuar',
      ),
      'answerNumber': (Object i) => 'Respuesta $i',
      'arLens': MessageLookupByLibrary.simpleMessage('Lente de RA'),
      'attachSystemLog': MessageLookupByLibrary.simpleMessage(
        'Adjuntar el registro del sistema',
      ),
      'aWordPhraseOrTag': MessageLookupByLibrary.simpleMessage(
        'Una palabra, frase o #etiqueta',
      ),
      'block': MessageLookupByLibrary.simpleMessage('Bloquear'),
      'blockAuthor': (Object author) => '¿Bloquear a $author?',
      'buildDetailsCopied': MessageLookupByLibrary.simpleMessage(
        'Detalles de la compilación copiados',
      ),
      'bullet': MessageLookupByLibrary.simpleMessage('•'),
      'cancel': MessageLookupByLibrary.simpleMessage('Cancelar'),
      'change': MessageLookupByLibrary.simpleMessage('Cambiar'),
      'changeEmail': MessageLookupByLibrary.simpleMessage('Cambiar correo'),
      'checkKyronReachable': MessageLookupByLibrary.simpleMessage(
        'Comprobar si Kyron está accesible',
      ),
      'checkEmailConfirm': MessageLookupByLibrary.simpleMessage(
        'Revisa tu correo para confirmar tu cuenta.',
      ),
      'closeCommunity': (Object communityName) => '¿Cerrar $communityName?',
      'closeIt': MessageLookupByLibrary.simpleMessage('Cerrar'),
      'closeThisCommunity': MessageLookupByLibrary.simpleMessage(
        'Cerrar esta comunidad',
      ),
      'confirmPassword': MessageLookupByLibrary.simpleMessage(
        'Confirmar contraseña',
      ),
      'contactSupport': MessageLookupByLibrary.simpleMessage(
        'Contactar con soporte',
      ),
      'continueWithEmail': MessageLookupByLibrary.simpleMessage(
        'Continuar con correo',
      ),
      'copy': MessageLookupByLibrary.simpleMessage('Copiar'),
      'copyReportInstead': MessageLookupByLibrary.simpleMessage(
        'Copiar informe en su lugar',
      ),
      'couldNotOpenGoogleSignIn': (Object error) =>
          'No se pudo abrir el inicio de sesión con Google. $error',
      'couldNotSignOut': (Object error) =>
          'No se pudo cerrar la sesión: $error',
      'couldNotTakePicture': MessageLookupByLibrary.simpleMessage(
        'No se pudo tomar esa foto.',
      ),
      'create': MessageLookupByLibrary.simpleMessage('Crear'),
      'createAccount': MessageLookupByLibrary.simpleMessage('Crear cuenta'),
      'createYourAccount':
          MessageLookupByLibrary.simpleMessage('Crea tu cuenta'),
      'createYourProfile':
          MessageLookupByLibrary.simpleMessage('Crea tu perfil'),
      'delete': MessageLookupByLibrary.simpleMessage('Eliminar'),
      'deleteThisComment': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar este comentario?',
      ),
      'deleteThisPost': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar esta publicación?',
      ),
      'describeAttachment': MessageLookupByLibrary.simpleMessage(
        'Describir este adjunto',
      ),
      'description': MessageLookupByLibrary.simpleMessage('Descripción'),
      'didCopied': MessageLookupByLibrary.simpleMessage(
        'DID copiado al portapapeles',
      ),
      'done': MessageLookupByLibrary.simpleMessage('Listo'),
      'drafts': MessageLookupByLibrary.simpleMessage('Borradores'),
      'editProfile': MessageLookupByLibrary.simpleMessage('Editar perfil'),
      'emailNotifications': MessageLookupByLibrary.simpleMessage(
        'Notificaciones por correo',
      ),
      'faceTrackingUnavailable': MessageLookupByLibrary.simpleMessage(
        'El seguimiento facial no está disponible en este dispositivo.',
      ),
      'followers': MessageLookupByLibrary.simpleMessage('Seguidores'),
      'following': MessageLookupByLibrary.simpleMessage('Siguiendo'),
      'forgotPassword': MessageLookupByLibrary.simpleMessage(
        '¿Olvidaste tu contraseña?',
      ),
      'guidesAndAnswers': MessageLookupByLibrary.simpleMessage(
        'Guías y respuestas a preguntas comunes',
      ),
      'handle': MessageLookupByLibrary.simpleMessage('nombre de usuario'),
      'helpCentre': MessageLookupByLibrary.simpleMessage('Centro de ayuda'),
      'helpAndSupport': MessageLookupByLibrary.simpleMessage('Ayuda y soporte'),
      'inOneLine': MessageLookupByLibrary.simpleMessage('En una línea'),
      'itDisappearsForBoth': MessageLookupByLibrary.simpleMessage(
        'Desaparece para ambos.',
      ),
      'itWillBeRemoved': MessageLookupByLibrary.simpleMessage(
        'Se eliminará del hilo.',
      ),
      'keepEditing': MessageLookupByLibrary.simpleMessage('Seguir editando'),
      'kyron': MessageLookupByLibrary.simpleMessage('Kyron'),
      'lagosDesign': MessageLookupByLibrary.simpleMessage('Diseño Lagos'),
      'leave': MessageLookupByLibrary.simpleMessage('Salir'),
      'leaveCommunity': (Object communityName) => '¿Salir de $communityName?',
      'letBackIn': MessageLookupByLibrary.simpleMessage('Permitir volver'),
      'loadMore': MessageLookupByLibrary.simpleMessage('Cargar más'),
      'logCleared': MessageLookupByLibrary.simpleMessage('Registro borrado'),
      'logCopied': MessageLookupByLibrary.simpleMessage('Registro copiado'),
      'logIn': MessageLookupByLibrary.simpleMessage('Iniciar sesión'),
      'logOut': MessageLookupByLibrary.simpleMessage('Cerrar sesión'),
      'logOutQuestion': MessageLookupByLibrary.simpleMessage('¿Cerrar sesión?'),
      'message': MessageLookupByLibrary.simpleMessage('Mensaje'),
      'mute': MessageLookupByLibrary.simpleMessage('Silenciar'),
      'mutedAndBlocked': MessageLookupByLibrary.simpleMessage(
        'Silenciados y bloqueados',
      ),
      'mutedWordsAndTags': MessageLookupByLibrary.simpleMessage(
        'Palabras y etiquetas silenciadas',
      ),
      'name': MessageLookupByLibrary.simpleMessage('Nombre'),
      'nameScreen': MessageLookupByLibrary.simpleMessage('Pantalla <nombre>'),
      'newEmailAddress': MessageLookupByLibrary.simpleMessage(
        'Nueva dirección de correo',
      ),
      'newPassword': MessageLookupByLibrary.simpleMessage('Nueva contraseña'),
      'newPost': MessageLookupByLibrary.simpleMessage('Nueva publicación'),
      'nothingToCopy': MessageLookupByLibrary.simpleMessage('Nada que copiar'),
      'notifications': MessageLookupByLibrary.simpleMessage('Notificaciones'),
      'notNow': MessageLookupByLibrary.simpleMessage('Ahora no'),
      'notSentTapRetry': MessageLookupByLibrary.simpleMessage(
        'No se envió. Toca para reintentar',
      ),
      'openInBrowser': MessageLookupByLibrary.simpleMessage(
        'Abrir en el navegador',
      ),
      'pageNotFound':
          MessageLookupByLibrary.simpleMessage('Página no encontrada'),
      'pickYourInterests': MessageLookupByLibrary.simpleMessage(
        'Elige tus intereses',
      ),
      'post': MessageLookupByLibrary.simpleMessage('Publicar'),
      'postAnalytics': MessageLookupByLibrary.simpleMessage(
        'Estadísticas de la publicación',
      ),
      'postInCommunity': (Object communityName) => 'Publicar en $communityName',
      'postTextCopied': MessageLookupByLibrary.simpleMessage(
        'Texto de la publicación copiado',
      ),
      'profileUpdated':
          MessageLookupByLibrary.simpleMessage('Perfil actualizado'),
      'pushNotifications': MessageLookupByLibrary.simpleMessage(
        'Notificaciones push',
      ),
      'quote': MessageLookupByLibrary.simpleMessage('Citar'),
      'quotePost': MessageLookupByLibrary.simpleMessage('Citar publicación'),
      'reachAPerson': MessageLookupByLibrary.simpleMessage(
        'Contactar a una persona',
      ),
      'remove': MessageLookupByLibrary.simpleMessage('Eliminar'),
      'removeMember': (Object memberName) => '¿Eliminar a $memberName?',
      'removeConversation': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar esta conversación?',
      ),
      'removeMessage': MessageLookupByLibrary.simpleMessage(
        '¿Eliminar este mensaje?',
      ),
      'repliesFollowsMentions': MessageLookupByLibrary.simpleMessage(
        'Respuestas, seguimientos y menciones',
      ),
      'reply': MessageLookupByLibrary.simpleMessage('Responder'),
      'report': MessageLookupByLibrary.simpleMessage('Reportar'),
      'reportCopied': MessageLookupByLibrary.simpleMessage(
        'Informe copiado. Pégalo en un correo al soporte.',
      ),
      'reportSent': MessageLookupByLibrary.simpleMessage('Informe enviado'),
      'repost': MessageLookupByLibrary.simpleMessage('Republicar'),
      'reset': MessageLookupByLibrary.simpleMessage('Restablecer'),
      'resetPassword': MessageLookupByLibrary.simpleMessage(
        'Restablecer tu contraseña',
      ),
      'retry': MessageLookupByLibrary.simpleMessage('Reintentar'),
      'save': MessageLookupByLibrary.simpleMessage('Guardar'),
      'saveDraft': MessageLookupByLibrary.simpleMessage('Guardar borrador'),
      'saySomething': (Object communityName) => 'Di algo a $communityName',
      'searchByNameOrHandle': MessageLookupByLibrary.simpleMessage(
        'Buscar por nombre o usuario',
      ),
      'searchCommunities': MessageLookupByLibrary.simpleMessage(
        'Buscar comunidades',
      ),
      'searchGIFs': MessageLookupByLibrary.simpleMessage('Buscar GIFs'),
      'searchLanguages': MessageLookupByLibrary.simpleMessage('Buscar idiomas'),
      'searchTrendingTags': MessageLookupByLibrary.simpleMessage(
        'Buscar etiquetas tendencias',
      ),
      'securityAlerts': MessageLookupByLibrary.simpleMessage(
        'Alertas de seguridad y cambios en la cuenta',
      ),
      'sendConfirmation': MessageLookupByLibrary.simpleMessage(
        'Enviar confirmación',
      ),
      'sendErrorReport': MessageLookupByLibrary.simpleMessage(
        'Enviar informe de error',
      ),
      'sendFeedback':
          MessageLookupByLibrary.simpleMessage('Enviar comentarios'),
      'sendReport': MessageLookupByLibrary.simpleMessage('Enviar informe'),
      'sendToSupport':
          MessageLookupByLibrary.simpleMessage('Enviar al soporte'),
      'serviceStatus':
          MessageLookupByLibrary.simpleMessage('Estado del servicio'),
      'shareAppLog': MessageLookupByLibrary.simpleMessage(
        'Compartir el registro de la app con soporte',
      ),
      'signedInAs':
          MessageLookupByLibrary.simpleMessage('Iniciaste sesión como'),
      'signInToKyron': MessageLookupByLibrary.simpleMessage(
        'Iniciar sesión en Kyron',
      ),
      'signupFailed': (Object error) => 'Error al registrarse: $error',
      'stay': MessageLookupByLibrary.simpleMessage('Permanecer'),
      'systemLog': MessageLookupByLibrary.simpleMessage('Registro del sistema'),
      'tellMissingBroken': MessageLookupByLibrary.simpleMessage(
        'Cuéntanos qué falta o no funciona',
      ),
      'theComposerNoPostButton': MessageLookupByLibrary.simpleMessage(
        'El compositor no tiene botón de publicar',
      ),
      'translate': MessageLookupByLibrary.simpleMessage('Traduccir'),
      'tryAgain': MessageLookupByLibrary.simpleMessage('Intentar de nuevo'),
      'undoRepost':
          MessageLookupByLibrary.simpleMessage('Deshacer republicación'),
      'updatePassword': MessageLookupByLibrary.simpleMessage(
        'Actualizar contraseña',
      ),
      'useDifferentAddress': MessageLookupByLibrary.simpleMessage(
        'Usar otra dirección',
      ),
      'whatHappened': MessageLookupByLibrary.simpleMessage('¿Qué pasó?'),
      'whatHappenedAndLookAt': MessageLookupByLibrary.simpleMessage(
        '¿Qué pasó y qué debemos revisar?',
      ),
      'whatInPicture': MessageLookupByLibrary.simpleMessage(
        '¿Qué hay en esta imagen?',
      ),
      'whatIsItFor': MessageLookupByLibrary.simpleMessage(
        '¿Para qué es? (opcional)',
      ),
      'whatYouDid': MessageLookupByLibrary.simpleMessage(
        'Lo que hiciste, lo que esperabas, lo que pasó',
      ),
      'whatYouWereDoing': MessageLookupByLibrary.simpleMessage(
        'Lo que estabas haciendo cuando pasó.',
      ),
      'normalised': MessageLookupByLibrary.simpleMessage('#\\\$normalised'),
      'postItSayItShowIt': MessageLookupByLibrary.simpleMessage(
        'Publícalo, dilo, muéstralo.',
      ),
      'textVoiceVideoPeopleRooms': MessageLookupByLibrary.simpleMessage(
        'Texto, voz y vídeo; las personas que los crean y los espacios donde conversan.',
      ),
      'alreadyOnKyron':
          MessageLookupByLibrary.simpleMessage('¿Ya estás en Kyron?'),
      'byContinuingAgreeTermsPrivacy': MessageLookupByLibrary.simpleMessage(
        'Al continuar, aceptas nuestros Términos y la Política de privacidad',
      ),
      'byContinuingAgreeTerms': MessageLookupByLibrary.simpleMessage(
        'Al continuar, aceptas nuestros',
      ),
      'googleSignInNeedsPhoneApp': MessageLookupByLibrary.simpleMessage(
        'El inicio de sesión con Google necesita la aplicación móvil',
      ),
      'googleSignInDesktopExplanation': (Object platform) =>
          'Google devuelve el inicio de sesión completado a Kyron mediante un enlace que solo Android e iOS pueden abrir. Por eso, en ${platform}, el navegador no tendría adónde volver.\n\nSi ya tienes una cuenta de Kyron mediante Google, usa Continuar con correo con esa misma dirección y toca ¿Olvidaste tu contraseña?; te enviaremos un enlace para establecer una.'
              .replaceAll(r'${platform}', platform.toString()),
      'loginFailed': MessageLookupByLibrary.simpleMessage(
        'No se pudo iniciar sesión. Comprueba tus credenciales.',
      ),
      'email': MessageLookupByLibrary.simpleMessage('Correo electrónico'),
      'password': MessageLookupByLibrary.simpleMessage('Contraseña'),
      'login': MessageLookupByLibrary.simpleMessage('Iniciar sesión'),
      'or': MessageLookupByLibrary.simpleMessage('o'),
      'username': MessageLookupByLibrary.simpleMessage('Nombre de usuario'),
      'usernameRule': MessageLookupByLibrary.simpleMessage(
        'El nombre de usuario debe estar en minúsculas (a-z, 0-9, _)',
      ),
      'passwordTooShort': MessageLookupByLibrary.simpleMessage(
        'La contraseña es demasiado corta',
      ),
      'continueAction': MessageLookupByLibrary.simpleMessage('Continuar'),
      'bySigningUpAgreeTerms': MessageLookupByLibrary.simpleMessage(
        'Al registrarte, aceptas nuestros',
      ),
      'terms': MessageLookupByLibrary.simpleMessage('Términos'),
      'and': MessageLookupByLibrary.simpleMessage('y'),
      'privacyPolicy': MessageLookupByLibrary.simpleMessage(
        'Política de privacidad',
      ),
      'googleSignIn': MessageLookupByLibrary.simpleMessage(
        'Iniciar sesión con Google',
      ),
      'googleSignUp': MessageLookupByLibrary.simpleMessage(
        'Registrarse con Google',
      ),
      'googleContinue': MessageLookupByLibrary.simpleMessage(
        'Continuar con Google',
      ),
      'literalwhetherKyronIsReachableRightNow':
          MessageLookupByLibrary.simpleMessage(
              'Si Kyron está disponible ahora'),
      'literalwhatThisAppHasBeenDoing': MessageLookupByLibrary.simpleMessage(
        'Qué ha estado haciendo esta app',
      ),
      'literalshareTheLogWithSupport': MessageLookupByLibrary.simpleMessage(
        'Compartir el registro con soporte',
      ),
      'literalclearCache': MessageLookupByLibrary.simpleMessage('Borrar caché'),
      'literalappVersion': MessageLookupByLibrary.simpleMessage(
        'Versión de la app',
      ),
      'literalreading': MessageLookupByLibrary.simpleMessage('Leyendo…'),
      'literalcheckAgain': MessageLookupByLibrary.simpleMessage(
        'Comprobar de nuevo',
      ),
      'literalkyronDidNotAnswer': MessageLookupByLibrary.simpleMessage(
        'Kyron no respondió',
      ),
      'literalnothingLoggedYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay registros',
      ),
      'literalswitchCamera':
          MessageLookupByLibrary.simpleMessage('Cambiar cámara'),
      'literaltheCameraIsClosed': MessageLookupByLibrary.simpleMessage(
        'La cámara está cerrada',
      ),
      'literaltakeAPicture':
          MessageLookupByLibrary.simpleMessage('Tomar una foto'),
      'literallensNameFaceLens': (dynamic lens) => '${lens.name}, lente facial',
      'literalcouldNotPostThatReply': MessageLookupByLibrary.simpleMessage(
        'No se pudo publicar esa respuesta.',
      ),
      'literalcouldNotLoadThisReply': MessageLookupByLibrary.simpleMessage(
        'No se pudo cargar esta respuesta',
      ),
      'literalthisReplyIsGone': MessageLookupByLibrary.simpleMessage(
        'Esta respuesta ya no existe',
      ),
      'literaladdAPhoto':
          MessageLookupByLibrary.simpleMessage('Agregar una foto'),
      'literaladdAClip':
          MessageLookupByLibrary.simpleMessage('Agregar un clip'),
      'literalstartACommunity': MessageLookupByLibrary.simpleMessage(
        'Crear una comunidad',
      ),
      'literalcouldNotLoadYourCommunities':
          MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar tus comunidades',
      ),
      'literalyouAreNotInAnyCommunities': MessageLookupByLibrary.simpleMessage(
        'No estás en ninguna comunidad',
      ),
      'literalcouldNotLoadCommunities': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar las comunidades',
      ),
      'literalpostInWidgetCommunityName': (dynamic widget) =>
          'Publicar en ${widget.community.name}',
      'literalsaySomethingToWidgetCommunityName': (dynamic widget) =>
          'Escribe algo para ${widget.community.name}',
      'literaltagSomeone': MessageLookupByLibrary.simpleMessage(
        'Etiquetar a alguien',
      ),
      'literalcloseWidgetCommunityName': (dynamic widget) =>
          '¿Cerrar ${widget.community.name}?',
      'literalonlyTheOwnerCanChangeThis': MessageLookupByLibrary.simpleMessage(
        'Solo el propietario puede cambiar esto',
      ),
      'literaltapTheBannerOrThePictureToChangeIt':
          MessageLookupByLibrary.simpleMessage(
        'Toca el banner o la imagen para cambiarla',
      ),
      'literalremoveMemberDisplayname': (dynamic member) =>
          '¿Eliminar a ${member.displayName}?',
      'literalcouldNotLoadTheMembers': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar los miembros',
      ),
      'literalnobodyHereYet': MessageLookupByLibrary.simpleMessage(
        'Todavía no hay nadie aquí',
      ),
      'literalmakeAModerator': MessageLookupByLibrary.simpleMessage(
        'Convertir en moderador',
      ),
      'literalremoveAsModerator': MessageLookupByLibrary.simpleMessage(
        'Quitar como moderador',
      ),
      'literalremoveFromCommunity': MessageLookupByLibrary.simpleMessage(
        'Eliminar de la comunidad',
      ),
      'literalcouldNotLoadThisList': MessageLookupByLibrary.simpleMessage(
        'No se pudo cargar esta lista',
      ),
      'literalnobodyHasBeenRemoved': MessageLookupByLibrary.simpleMessage(
        'Nadie ha sido eliminado',
      ),
      'literalpostInCommunityName': (dynamic community) =>
          'Publicar en ${community.name}',
      'literalcouldNotOpenThisCommunity': MessageLookupByLibrary.simpleMessage(
        'No se pudo abrir esta comunidad',
      ),
      'literalthisCommunity': MessageLookupByLibrary.simpleMessage(
        'Esta comunidad',
      ),
      'literalshareThisCommunity': MessageLookupByLibrary.simpleMessage(
        'Compartir esta comunidad',
      ),
      'literalcopyLink': MessageLookupByLibrary.simpleMessage('Copiar enlace'),
      'literallinkCopied':
          MessageLookupByLibrary.simpleMessage('Enlace copiado'),
      'literalleaveCommunityName': (dynamic community) =>
          '¿Salir de ${community.name}?',
      'literalyouHaveLeftCommunityName': (dynamic community) =>
          'Has salido de ${community.name}',
      'literaladdAVideo':
          MessageLookupByLibrary.simpleMessage('Agregar un video'),
      'literaladdAGif': MessageLookupByLibrary.simpleMessage('Agregar un GIF'),
      'literalrecordAVoicePost': MessageLookupByLibrary.simpleMessage(
        'Grabar una publicación de voz',
      ),
      'literalremoveThePoll': MessageLookupByLibrary.simpleMessage(
        'Eliminar la encuesta',
      ),
      'literaladdAPoll': MessageLookupByLibrary.simpleMessage(
        'Agregar una encuesta',
      ),
      'literaladdAHashtag': MessageLookupByLibrary.simpleMessage(
        'Agregar un hashtag',
      ),
      'literaldraftSaved': MessageLookupByLibrary.simpleMessage(
        'Borrador guardado',
      ),
      'literalnoDrafts': MessageLookupByLibrary.simpleMessage('Sin borradores'),
      'literalcouldNotLoadTrending': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar las tendencias',
      ),
      'literalnothingIsTrendingYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay tendencias',
      ),
      'literalcouldNotLoadTopics': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar los temas',
      ),
      'literalnoTopicsYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay temas',
      ),
      'literalcouldNotLoadSuggestions': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar las sugerencias',
      ),
      'literalnobodyLeftToSuggest': MessageLookupByLibrary.simpleMessage(
        'No hay nadie más para sugerir',
      ),
      'literalyouExampleCom': MessageLookupByLibrary.simpleMessage(
        'you@example.com',
      ),
      'literalsendTheLink': MessageLookupByLibrary.simpleMessage(
        'Enviar el enlace',
      ),
      'literalopenTheMailFromKyron': MessageLookupByLibrary.simpleMessage(
        'Abre el correo de Kyron',
      ),
      'literaltapTheLinkInsideIt': MessageLookupByLibrary.simpleMessage(
        'Toca el enlace dentro',
      ),
      'literalsetAPasswordAndCarryOn': MessageLookupByLibrary.simpleMessage(
        'Establece una contraseña y continúa',
      ),
      'literalsendAgainInCooldownS': (Object _cooldown) =>
          'Reenviar en ${_cooldown}s',
      'literalsendAgain': MessageLookupByLibrary.simpleMessage('Reenviar'),
      'literalnormalised': (Object normalised) => '#$normalised',
      'literalcouldNotLoadYourMessages': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar tus mensajes',
      ),
      'literalnothingUnread':
          MessageLookupByLibrary.simpleMessage('Nada por leer'),
      'literalnoMessagesYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay mensajes',
      ),
      'literalnothingMuted': MessageLookupByLibrary.simpleMessage(
        'Nada silenciado',
      ),
      'literalnoLikesYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay me gusta',
      ),
      'literalnoRepliesYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay respuestas',
      ),
      'literalnoNewFollowers': MessageLookupByLibrary.simpleMessage(
        'No hay nuevos seguidores',
      ),
      'literalnoRepostsYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay reenvíos',
      ),
      'literalyouAreAllCaughtUp': MessageLookupByLibrary.simpleMessage(
        'Ya estás al día',
      ),
      'literalcouldNotLoadNotifications': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar las notificaciones',
      ),
      'literalcoverPhoto':
          MessageLookupByLibrary.simpleMessage('Foto de portada'),
      'literalchooseFromGallery': MessageLookupByLibrary.simpleMessage(
        'Elegir de la galería',
      ),
      'literaluseOneOfOurs': MessageLookupByLibrary.simpleMessage(
        'Usa una de las nuestras',
      ),
      'literaltapToAddAPhotoAndACover': MessageLookupByLibrary.simpleMessage(
        'Toca para añadir una foto y una portada',
      ),
      'literalnoInterestsYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay intereses',
      ),
      'literaldiscoverPeople': MessageLookupByLibrary.simpleMessage(
        'Descubrir personas',
      ),
      'literalcancelReply': MessageLookupByLibrary.simpleMessage(
        'Cancelar respuesta',
      ),
      'literalcouldNotLoadThisPost': MessageLookupByLibrary.simpleMessage(
        'No se pudo cargar esta publicación',
      ),
      'literalshareThisProfile': MessageLookupByLibrary.simpleMessage(
        'Compartir este perfil',
      ),
      'literalcouldNotLoadThesePosts': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar estas publicaciones',
      ),
      'literalyouHaveNotPostedYet': MessageLookupByLibrary.simpleMessage(
        'Aún no has publicado',
      ),
      'literalnoPostsYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay publicaciones',
      ),
      'literalnothingToLookAtYet': MessageLookupByLibrary.simpleMessage(
        'Aún no hay nada que ver',
      ),
      'literalkeepTyping': MessageLookupByLibrary.simpleMessage(
        'Sigue escribiendo',
      ),
      'literalsearchFailed': MessageLookupByLibrary.simpleMessage(
        'Búsqueda fallida',
      ),
      'literalnothingMatched': MessageLookupByLibrary.simpleMessage(
        'No hay coincidencias',
      ),
      'literalcouldNotSignOutDescribeapierrorE': (Object describeApiError) =>
          'No se pudo cerrar sesión: $describeApiError',
      'literalnoDidYet': MessageLookupByLibrary.simpleMessage('Aún no hay DID'),
      'literalpasswordLogin': MessageLookupByLibrary.simpleMessage(
        'Contraseña y acceso',
      ),
      'literalmutedAndBlockedAccounts': MessageLookupByLibrary.simpleMessage(
        'Cuentas silenciadas y bloqueadas',
      ),
      'literalfontSize':
          MessageLookupByLibrary.simpleMessage('Tamaño de fuente'),
      'literalpushNotifications': MessageLookupByLibrary.simpleMessage(
        'Notificaciones push',
      ),
      'literaldataSaver':
          MessageLookupByLibrary.simpleMessage('Ahorro de datos'),
      'literalcontactSupport': MessageLookupByLibrary.simpleMessage(
        'Contactar con soporte',
      ),
      'literalsendFeedback': MessageLookupByLibrary.simpleMessage(
        'Enviar comentarios',
      ),
      'literalappLanguage': MessageLookupByLibrary.simpleMessage(
        'Idioma de la app',
      ),
      'literalprimaryLanguage': MessageLookupByLibrary.simpleMessage(
        'Idioma principal',
      ),
      'literalcontentLanguages': MessageLookupByLibrary.simpleMessage(
        'Idiomas del contenido',
      ),
      'literalremoveLanguageEnglishname': (dynamic language) =>
          'Eliminar ${language.englishName}',
      'literalsentItIsReportFiledNumber': (dynamic filed) =>
          'Enviado. Es el informe #${filed.number}.',
      'literalfeedbackCannotBeSentRightNow':
          MessageLookupByLibrary.simpleMessage(
        'No se puede enviar comentarios ahora mismo',
      ),
      'literalwhatYouDidWhatYouExpectedWhatHappened':
          MessageLookupByLibrary.simpleMessage(
        'Qué hiciste, qué esperabas, qué pasó ',
      ),
      'literalverificationFailedDescribeapierrorE': (Object describeApiError) =>
          'Verificación fallida: $describeApiError',
      'literalverificationCodeResent': MessageLookupByLibrary.simpleMessage(
        'Código de verificación reenviado.',
      ),
      'literalverifyEmail': MessageLookupByLibrary.simpleMessage(
        'Verificar correo electrónico',
      ),
      'literalresendCode':
          MessageLookupByLibrary.simpleMessage('Reenviar código'),
      'literalremoveThisConversation': MessageLookupByLibrary.simpleMessage(
        'Eliminar esta conversación',
      ),
      'literalmutedYouWillNotBeNotified': MessageLookupByLibrary.simpleMessage(
        'Silenciado. No recibirás notificaciones.',
      ),
      'literalblockThisAccount': MessageLookupByLibrary.simpleMessage(
        '¿Bloquear esta cuenta?',
      ),
      'literalyouAreSignedOut': MessageLookupByLibrary.simpleMessage(
        'Has cerrado sesión.',
      ),
      'literalcouldNotLoadThisConversation':
          MessageLookupByLibrary.simpleMessage(
        'No se pudo cargar esta conversación',
      ),
      'literalsaySomething': MessageLookupByLibrary.simpleMessage('Di algo'),
      'literalcopyText': MessageLookupByLibrary.simpleMessage('Copiar texto'),
      'literaldoNotReply': MessageLookupByLibrary.simpleMessage('No responder'),
      'literalremoveFromSaved': MessageLookupByLibrary.simpleMessage(
        'Quitar de guardados',
      ),
      'literalturnSoundOn':
          MessageLookupByLibrary.simpleMessage('Activar sonido'),
      'literalturnSoundOff': MessageLookupByLibrary.simpleMessage(
        'Desactivar sonido',
      ),
      'literalthatLinkIsNotOneThisCanOpen':
          MessageLookupByLibrary.simpleMessage(
        'Ese enlace no se puede abrir aquí.',
      ),
      'literalnoBrowserOnThisDeviceTookThatLink':
          MessageLookupByLibrary.simpleMessage(
        'Ningún navegador en este dispositivo pudo abrir ese enlace.',
      ),
      'literalopenReply':
          MessageLookupByLibrary.simpleMessage('Abrir respuesta'),
      'literallabelCount': (Object label, Object count) => '$label, $count',
      'literalindex1': (dynamic index) => '${index + 1}',
      'literalfirstyearIndex': (dynamic _firstYear) => '$_firstYear',
      'literalgifsAreNotSetUp': MessageLookupByLibrary.simpleMessage(
        'Los GIF no están configurados',
      ),
      'literalcouldNotLoadGifs': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar los GIF',
      ),
      'literalnothingFound': MessageLookupByLibrary.simpleMessage(
        'No se encontró nada',
      ),
      'literalthatGifCouldNotBeDownloaded':
          MessageLookupByLibrary.simpleMessage(
        'Ese GIF no se pudo descargar.',
      ),
      'literaladdAnInterest': MessageLookupByLibrary.simpleMessage(
        'Agregar un interés',
      ),
      'literalcouldNotLoadTrendingTags': MessageLookupByLibrary.simpleMessage(
        'No se pudieron cargar las etiquetas de tendencia',
      ),
      'literalnoTrendingTagMatchesThat': MessageLookupByLibrary.simpleMessage(
        'Ninguna etiqueta de tendencia coincide con eso',
      ),
      'literalyouAlreadyFollowEveryTrendingTag':
          MessageLookupByLibrary.simpleMessage(
        'Ya sigues todas las etiquetas de tendencia',
      ),
      'literalremoveLabel': (Object label) => 'Eliminar $label',
      'literaladdLabelAsATab': (Object label) => 'Agregar $label como pestaña',
      'literalcouldNotSearch': MessageLookupByLibrary.simpleMessage(
        'No se pudo buscar',
      ),
      'literalwhoDoYouWantToTag': MessageLookupByLibrary.simpleMessage(
        '¿A quién quieres etiquetar?',
      ),
      'literalnobodyFound': MessageLookupByLibrary.simpleMessage(
        'No se encontró a nadie',
      ),
      'literalshowPassword': MessageLookupByLibrary.simpleMessage(
        'Mostrar contraseña',
      ),
      'literalhidePassword': MessageLookupByLibrary.simpleMessage(
        'Ocultar contraseña',
      ),
      'literaltranslatePost': MessageLookupByLibrary.simpleMessage(
        'Traducir publicación',
      ),
      'literalcopyPostText': MessageLookupByLibrary.simpleMessage(
        'Copiar texto de la publicación',
      ),
      'literalcopyLinkToPost': MessageLookupByLibrary.simpleMessage(
        'Copiar enlace de la publicación',
      ),
      'literalshowMorePostsLikeThis': MessageLookupByLibrary.simpleMessage(
        'Mostrar más publicaciones como esta',
      ),
      'literalnotInterestedInThis': MessageLookupByLibrary.simpleMessage(
        'No me interesa esto',
      ),
      'literalhidesItAndTellsUsToShowFewerLikeIt':
          MessageLookupByLibrary.simpleMessage(
        'La oculta y nos indica mostrar menos contenido similar',
      ),
      'literalhideThisPost': MessageLookupByLibrary.simpleMessage(
        'Ocultar esta publicación',
      ),
      'literalmuteThisThread': MessageLookupByLibrary.simpleMessage(
        'Silenciar este hilo',
      ),
      'literalstopSeeingThisPostAndRepliesToIt':
          MessageLookupByLibrary.simpleMessage(
        'Dejar de ver esta publicación y sus respuestas',
      ),
      'literalmuteWordsOrTags': MessageLookupByLibrary.simpleMessage(
        'Silenciar palabras o etiquetas',
      ),
      'literalviewersLikesSavesAndComments':
          MessageLookupByLibrary.simpleMessage(
        'Vistas, me gusta, guardados y comentarios',
      ),
      'literalwhoCanReply': MessageLookupByLibrary.simpleMessage(
        'Quién puede responder',
      ),
      'literaldeletePost': MessageLookupByLibrary.simpleMessage(
        'Eliminar publicación',
      ),
      'literalmuteAuthor': (Object author) => 'Silenciar a $author',
      'literalblockAuthor': (Object author) => 'Bloquear a $author',
      'literalreportPost': MessageLookupByLibrary.simpleMessage(
        'Denunciar publicación',
      ),
      'literalreportAuthor': (Object author) => 'Denunciar a $author',
      'literalthatDidNotGoThroughTryAgain':
          MessageLookupByLibrary.simpleMessage(
        'No se pudo enviar. Inténtalo de nuevo.',
      ),
      'literalblockAuthor2': (Object author) => '¿Bloquear a $author?',
      'literalshowResults': MessageLookupByLibrary.simpleMessage(
        'Mostrar resultados',
      ),
      'literallabelDate': (Object label) => '\\$label fecha',
      'literalshareVia': MessageLookupByLibrary.simpleMessage('Compartir vía…'),
      'literalhandItToAnotherApp': MessageLookupByLibrary.simpleMessage(
        'Abrir con otra app',
      ),
      'literalshareWithAQuote': MessageLookupByLibrary.simpleMessage(
        'Compartir con cita',
      ),
      'literalpostItWithYourOwnWordsAboveIt':
          MessageLookupByLibrary.simpleMessage(
        'Publicarlo con tus propias palabras arriba',
      ),
      'literalsavedPosts': MessageLookupByLibrary.simpleMessage(
        'Publicaciones guardadas',
      ),
      'literallikedPosts': MessageLookupByLibrary.simpleMessage(
        'Publicaciones que te gustaron',
      ),
      'literalstoriesRibbonStoriesLengthItems': (dynamic stories) =>
          'Historias, ${stories.length} elementos',
      'literalwhatYouPostIsYours': MessageLookupByLibrary.simpleMessage(
        'Lo que publicas es tuyo',
      ),
      'literalwhatKyronKeeps': MessageLookupByLibrary.simpleMessage(
        'Lo que Kyron conserva',
      ),
      'literalhowToBehave': MessageLookupByLibrary.simpleMessage(
        'Cómo comportarse',
      ),
      'literalcloseTabLabel': (dynamic tab) => 'Cerrar ${tab.label}',
      'literal1PageOpen':
          MessageLookupByLibrary.simpleMessage('1 página abierta'),
      'literalcountPagesOpen': (Object count) => '$count páginas abiertas',
      'literalstopLoading':
          MessageLookupByLibrary.simpleMessage('Detener carga'),
      'literalshareThisPage': MessageLookupByLibrary.simpleMessage(
        'Compartir esta página',
      ),
      'literalnoAppOnThisDeviceOpensUriSchemeLinks': (dynamic uri) =>
          'Ninguna aplicación en este dispositivo abre enlaces ${uri.scheme}.',
      'literalcloseTheBrowser': MessageLookupByLibrary.simpleMessage(
        'Cerrar el navegador',
      ),
      'literalcloseAllPages': MessageLookupByLibrary.simpleMessage(
        'Cerrar todas las páginas',
      ),
      'literalremoveThisPoll': MessageLookupByLibrary.simpleMessage(
        'Eliminar esta encuesta',
      ),
      'literalremoveThisAnswer': MessageLookupByLibrary.simpleMessage(
        'Eliminar esta respuesta',
      ),
      'literalstartRecording': MessageLookupByLibrary.simpleMessage(
        'Iniciar grabación',
      ),
      'literalrecordAgain':
          MessageLookupByLibrary.simpleMessage('Volver a grabar'),
      'home': MessageLookupByLibrary.simpleMessage("Inicio"),
      'explore': MessageLookupByLibrary.simpleMessage("Explorar"),
      'communities': MessageLookupByLibrary.simpleMessage("Comunidades"),
      'messages': MessageLookupByLibrary.simpleMessage("Mensajes"),
      'languages': MessageLookupByLibrary.simpleMessage("Idiomas"),
      'selectAppLanguage': MessageLookupByLibrary.simpleMessage(
          "Selecciona el idioma de la interfaz de la aplicación."),
      'selectPrimaryLanguage': MessageLookupByLibrary.simpleMessage(
          "Selecciona tu idioma preferido para las traducciones de tu feed."),
      'selectContentLanguages': MessageLookupByLibrary.simpleMessage(
          "Selecciona los idiomas que quieres incluir en tus feeds. Si no eliges ninguno, se mostrarán todos los idiomas."),
      'kyronWordsStillBeingTranslated': MessageLookupByLibrary.simpleMessage(
          "Las palabras de Kyron todavía se están traduciendo, por lo que la mayoría de las pantallas seguirán en inglés por ahora."),
      'hashtagsEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Los hashtags aparecerán aquí cuando la gente empiece a usarlos."),
      'topicsEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Kyron configura los temas y ahora no hay ninguno. Vuelve a comprobarlo pronto."),
      'peopleEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Ya sigues a todas las personas que Kyron mostraría aquí."),
      'communitiesEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Encuentra una en Descubrir o crea la tuya."),
      'messagesCaughtUp': MessageLookupByLibrary.simpleMessage(
          "Todas las conversaciones están al día."),
      'messagesNoMessages': MessageLookupByLibrary.simpleMessage(
          "Abre el perfil de alguien y toca Mensaje para iniciar una conversación."),
      'notificationLikesDetail': MessageLookupByLibrary.simpleMessage(
          "Cuando a alguien le gusta una de tus publicaciones, aparecerá aquí."),
      'notificationRepliesDetail': MessageLookupByLibrary.simpleMessage(
          "Las respuestas a tus publicaciones aparecerán aquí."),
      'notificationFollowersDetail': MessageLookupByLibrary.simpleMessage(
          "Las personas que te siguen aparecerán aquí."),
      'notificationRepostsDetail': MessageLookupByLibrary.simpleMessage(
          "Cuando alguien comparte de nuevo una publicación tuya, aparecerá aquí."),
      'notificationEmptyDetail': MessageLookupByLibrary.simpleMessage(
          "Los Me gusta, las respuestas y los nuevos seguidores aparecerán aquí cuando lleguen."),
      'gettingHelp': MessageLookupByLibrary.simpleMessage("Obtener ayuda"),
      'send': MessageLookupByLibrary.simpleMessage("Enviar"),
      'close': MessageLookupByLibrary.simpleMessage("Cerrar"),
      'search': MessageLookupByLibrary.simpleMessage("Buscar"),
      'settings': MessageLookupByLibrary.simpleMessage("Ajustes"),
      'menu': MessageLookupByLibrary.simpleMessage("Menú"),
      'clear': MessageLookupByLibrary.simpleMessage("Borrar"),
      'manage': MessageLookupByLibrary.simpleMessage("Administrar"),
      'join': MessageLookupByLibrary.simpleMessage("Unirse"),
      'video': MessageLookupByLibrary.simpleMessage("Vídeo"),
      'contentLanguagesNotFilteringYet': MessageLookupByLibrary.simpleMessage(
          "Las publicaciones todavía no incluyen un idioma, por lo que esto aún no filtra tu feed. Tu elección se conservará para cuando lo incluyan."),
      'addMoreLanguages':
          MessageLookupByLibrary.simpleMessage("Añadir más idiomas…"),
      'translationNotBuiltYet': MessageLookupByLibrary.simpleMessage(
          "La traducción todavía no está disponible. Hoy nada de tu feed se traduce; esta elección se conservará para cuando lo esté."),
      'supportEarlyExplanation': MessageLookupByLibrary.simpleMessage(
          "Kyron todavía está empezando. La forma más rápida de contactar con alguien que pueda resolver un problema es abrir una incidencia. Incluye qué estabas haciendo y qué ocurrió."),
      'supportInboxNotYet': MessageLookupByLibrary.simpleMessage(
          "Todavía no hay una bandeja de soporte en la aplicación, así que esta pantalla te dirige al lugar que realmente se supervisa en vez de a un formulario que no llega a ninguna parte."),
      'ui_communities_screen_what_is_it_for_optional_39b687':
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      'ui_settings_screen_you_will_need_to_sign_in_again_to_get_back_to_yo_3dc001':
          MessageLookupByLibrary.simpleMessage(
              "You will need to sign in again to get back to your account."),
      'ui_settings_subscreens_new_email_address_dab96e':
          MessageLookupByLibrary.simpleMessage("New email address"),
      'ui_settings_subscreens_new_password_88c1bf':
          MessageLookupByLibrary.simpleMessage("New password"),
      'ui_settings_subscreens_confirm_password_41d040':
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      'ui_settings_subscreens_in_one_line_06bdaf':
          MessageLookupByLibrary.simpleMessage("In one line"),
      'ui_settings_subscreens_what_happened_977dd8':
          MessageLookupByLibrary.simpleMessage("What happened"),
      'ui_onboard_step3_screen_skip_7b13d8':
          MessageLookupByLibrary.simpleMessage("Skip"),
      'ui_onboard_step3_screen_finish_5c0ad8':
          MessageLookupByLibrary.simpleMessage("Finish"),
      'audit_about_screen_12_mb_e39721d6':
          MessageLookupByLibrary.simpleMessage("12 MB"),
      'audit_about_subscreens_round_trip_64776b4c':
          MessageLookupByLibrary.simpleMessage("Round trip"),
      'audit_about_subscreens_token_verification_7934e1f2':
          MessageLookupByLibrary.simpleMessage("TOKEN VERIFICATION"),
      'audit_about_subscreens_support_kyron_so_a3a84d0f':
          MessageLookupByLibrary.simpleMessage("support@kyron.so"),
      'audit_ar_lens_screen_try_again_cdec8872':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_browser_engine_window_stop_39c04883':
          MessageLookupByLibrary.simpleMessage("window.stop();"),
      'audit_browser_sheet_try_again_44bc94ba':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_coming_soon_screen_starting_a_broadcast_now_would_put_you_in_ca771e8b':
          MessageLookupByLibrary.simpleMessage(
              "Starting a broadcast now would put you in a room nobody could"),
      'audit_communities_screen_start_a_community_06c8ec4f':
          MessageLookupByLibrary.simpleMessage("Start a community"),
      'audit_communities_screen_what_is_it_for_optional_e7e82092':
          MessageLookupByLibrary.simpleMessage("What is it for? (optional)"),
      'audit_community_manage_screen_closing_it_f490fb09':
          MessageLookupByLibrary.simpleMessage("Closing it"),
      'audit_community_manage_screen_back_in_e495a750':
          MessageLookupByLibrary.simpleMessage("back in."),
      'audit_community_manage_screen_back_in_from_this_list_9496a4fd':
          MessageLookupByLibrary.simpleMessage("back in from this list."),
      'audit_community_screen_join_first_7798cafc':
          MessageLookupByLibrary.simpleMessage("join first"),
      'audit_composer_screen_coming_soon_431fd23d':
          MessageLookupByLibrary.simpleMessage("coming soon"),
      'audit_composer_screen_posting_as_you_45d69932':
          MessageLookupByLibrary.simpleMessage("Posting as you"),
      'audit_drafts_screen_just_now_17a8d48a':
          MessageLookupByLibrary.simpleMessage("Just now"),
      'audit_explore_screen_topic_1_83830b41':
          MessageLookupByLibrary.simpleMessage("Topic 1"),
      'audit_forgot_password_screen_its_way_to_it_now_271a6cea':
          MessageLookupByLibrary.simpleMessage("its way to it now."),
      'audit_forgot_password_screen_has_anything_65044193':
          MessageLookupByLibrary.simpleMessage("has anything."),
      'audit_post_analytics_screen_viewers_per_day_5d881f10':
          MessageLookupByLibrary.simpleMessage("VIEWERS PER DAY"),
      'audit_post_detail_screen_sublist_1_join_b0a5d508':
          MessageLookupByLibrary.simpleMessage(").sublist(1).join("),
      'audit_report_screen_this_post_820d9740':
          MessageLookupByLibrary.simpleMessage("this post"),
      'audit_report_screen_anything_to_add_optional_f0051fa4':
          MessageLookupByLibrary.simpleMessage("Anything to add? (optional)"),
      'audit_settings_screen_log_out_0b39bfb2':
          MessageLookupByLibrary.simpleMessage("Log Out"),
      'audit_settings_screen_your_account_bcdf27af':
          MessageLookupByLibrary.simpleMessage("Your account"),
      'audit_settings_screen_did_plc_abc_825b4f49':
          MessageLookupByLibrary.simpleMessage("did:plc:abc…"),
      'audit_settings_subscreens_confirm_password_f0e1f449':
          MessageLookupByLibrary.simpleMessage("Confirm password"),
      'audit_settings_subscreens_not_now_e1657fa9':
          MessageLookupByLibrary.simpleMessage("not now"),
      'audit_create_fab_post_in_this_community_0a42daf2':
          MessageLookupByLibrary.simpleMessage("post in this community"),
      'audit_url_preview_its_own_8b362f95':
          MessageLookupByLibrary.simpleMessage("its own."),
      'audit_empty_state_try_again_80ef48cd':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_feed_canvas_for_you_aa3c510d':
          MessageLookupByLibrary.simpleMessage("For You"),
      'audit_google_button_not_bbd76526':
          MessageLookupByLibrary.simpleMessage(", not"),
      'audit_inline_video_am_i_moving_4618f78c':
          MessageLookupByLibrary.simpleMessage("am I moving"),
      'audit_inline_video_turn_sound_on_83671c54':
          MessageLookupByLibrary.simpleMessage("Turn sound on"),
      'audit_inline_video_turn_sound_off_97714bbc':
          MessageLookupByLibrary.simpleMessage("Turn sound off"),
      'audit_interest_tabs_for_you_7ef9e823':
          MessageLookupByLibrary.simpleMessage("For You"),
      'audit_interest_tabs_your_tabs_c3ba148f':
          MessageLookupByLibrary.simpleMessage("Your tabs"),
      'audit_media_tray_alt_784030d4':
          MessageLookupByLibrary.simpleMessage("+ ALT"),
      'audit_mention_picker_sheet_try_again_fd5d5dd7':
          MessageLookupByLibrary.simpleMessage("Try again"),
      'audit_password_requirements_symbol_322aed1e':
          MessageLookupByLibrary.simpleMessage("Symbol (!@#…)"),
      'audit_post_list_view_could_not_load_4dd86c79':
          MessageLookupByLibrary.simpleMessage("could not load"),
      'audit_post_options_sheet_this_post_99bfa981':
          MessageLookupByLibrary.simpleMessage("this post"),
      'audit_post_text_a_b_780da9a1':
          MessageLookupByLibrary.simpleMessage("a#b"),
      'audit_search_filter_sheet_from_an_account_f6a22687':
          MessageLookupByLibrary.simpleMessage("From an account"),
      'audit_skeleton_loading_18e82bcc':
          MessageLookupByLibrary.simpleMessage("Loading…"),
      'audit_sliding_drawer_content_kyron_v1_0_0_d696e73a':
          MessageLookupByLibrary.simpleMessage("Kyron v1.0.0"),
      'audit_story_pill_posting_bb613f87':
          MessageLookupByLibrary.simpleMessage("Posting…"),
      'audit_story_viewer_your_story_b706ecb4':
          MessageLookupByLibrary.simpleMessage("Your Story"),
      'audit_story_viewer_copy_story_link_2bd1546c':
          MessageLookupByLibrary.simpleMessage("Copy story link"),
      'audit_story_viewer_3h_ago_174dc80d':
          MessageLookupByLibrary.simpleMessage("3h ago"),
      'audit_terms_gate_your_account_your_posts_and_what_you_tap_o_b0ad78ef':
          MessageLookupByLibrary.simpleMessage(
              "Your account, your posts, and what you tap on so"),
      'audit_topic_picker_add_a_topic_25baaf8a':
          MessageLookupByLibrary.simpleMessage("Add a topic"),
      'ui_communities': MessageLookupByLibrary.simpleMessage("Communities"),
      'ui_settings': MessageLookupByLibrary.simpleMessage("Settings"),
      'ui_appearance': MessageLookupByLibrary.simpleMessage("Appearance"),
      'ui_language': MessageLookupByLibrary.simpleMessage("Language"),
      'ui_account': MessageLookupByLibrary.simpleMessage("Account"),
      'ui_content_display':
          MessageLookupByLibrary.simpleMessage("Content & Display"),
      'ui_app_device': MessageLookupByLibrary.simpleMessage("App & Device"),
      'ui_terms': MessageLookupByLibrary.simpleMessage("Terms"),
      'ui_privacy': MessageLookupByLibrary.simpleMessage("Privacy"),
      'ui_help': MessageLookupByLibrary.simpleMessage("Help"),
      'ui_feedback': MessageLookupByLibrary.simpleMessage("Feedback"),
      'ui_decentralized_id':
          MessageLookupByLibrary.simpleMessage("Decentralized ID"),
      'ui_find_people_on_kyron':
          MessageLookupByLibrary.simpleMessage("Find people on Kyron"),
      'ui_search_everything_posted':
          MessageLookupByLibrary.simpleMessage("Search everything posted"),
      'ui_search_by_handle_or_display_name':
          MessageLookupByLibrary.simpleMessage(
              "Search by handle or display name."),
      'ui_words_or_filter': MessageLookupByLibrary.simpleMessage(
          "Words, or a filter — an account, a date range, or what a post carries."),
      'ui_two_characters_or_more':
          MessageLookupByLibrary.simpleMessage("Two characters or more."),
      'ui_no_posts_match_filters':
          MessageLookupByLibrary.simpleMessage("No posts match those filters."),
      'ui_search_clear': MessageLookupByLibrary.simpleMessage("Clear"),
      'ui_search_filters': MessageLookupByLibrary.simpleMessage("Filters"),
      'ui_post_text_copied':
          MessageLookupByLibrary.simpleMessage("Post text copied"),
      'ui_link_copied': MessageLookupByLibrary.simpleMessage("Link copied"),
      'ui_interest_noted': MessageLookupByLibrary.simpleMessage(
          "Noted. This helps shape what you are shown."),
      'ui_posts_hidden': MessageLookupByLibrary.simpleMessage(
          "Hidden. We will show you fewer like it."),
      'ui_post_hidden': MessageLookupByLibrary.simpleMessage("Post hidden"),
      'ui_thread_muted': MessageLookupByLibrary.simpleMessage("Thread muted"),
      'ui_post_deleted': MessageLookupByLibrary.simpleMessage("Post deleted"),
      'ui_post_delete_detail': MessageLookupByLibrary.simpleMessage(
          "It is removed from your profile and from everyone else's feed. Replies to it go with it."),
      'ui_block_detail': MessageLookupByLibrary.simpleMessage(
          "Neither of you will see the other on Kyron, and any follow between you is removed. They are not told."),
      'ui_mute_detail': MessageLookupByLibrary.simpleMessage(
          "You will stop seeing their posts. They are not told."),
      'ui_about_terms_of_service':
          MessageLookupByLibrary.simpleMessage("Terms of Service"),
      'ui_about_privacy_policy':
          MessageLookupByLibrary.simpleMessage("Privacy Policy"),
      'ui_settings_profile_contact': MessageLookupByLibrary.simpleMessage(
          "Your profile and contact information"),
      'ui_settings_security':
          MessageLookupByLibrary.simpleMessage("Security settings"),
      'ui_settings_muted_blocked':
          MessageLookupByLibrary.simpleMessage("Who you have muted or blocked"),
      'ui_settings_content_display':
          MessageLookupByLibrary.simpleMessage("Content & Display"),
      'ui_settings_app_device':
          MessageLookupByLibrary.simpleMessage("App & Device"),
      'ui_settings_data_saver':
          MessageLookupByLibrary.simpleMessage("Data Saver"),
      'ui_settings_language_detail':
          MessageLookupByLibrary.simpleMessage("Choose your language"),
      'ui_settings_notifications_detail':
          MessageLookupByLibrary.simpleMessage("Notification preferences"),
      'ui_settings_help_articles':
          MessageLookupByLibrary.simpleMessage("Browse help articles"),
      'ui_settings_team_help':
          MessageLookupByLibrary.simpleMessage("Get help from our team"),
      'ui_settings_feedback_detail':
          MessageLookupByLibrary.simpleMessage("Tell us what you think"),
      'ui_could_not_load_profile':
          MessageLookupByLibrary.simpleMessage("Could not load your profile"),
      'ui_search_people': MessageLookupByLibrary.simpleMessage("Search people"),
      'ui_search_posts': MessageLookupByLibrary.simpleMessage("Search posts"),
      'ui_this_post': MessageLookupByLibrary.simpleMessage("this post"),
      'authorPostsHidden': (Object author) =>
          'You will not see posts from $author',
      'authorBlocked': (Object author) => '$author blocked',
      'nothingMatchesQuery': (Object what) =>
          'Nothing on Kyron matches "$what"',
      'repliesPolicy': (Object policy) => 'Replies: $policy',
      'ui_preferences': MessageLookupByLibrary.simpleMessage("Preferences"),
      'ui_appearance_detail': MessageLookupByLibrary.simpleMessage(
          "Light, dark, or whatever the phone is set to"),
      'ui_legal': MessageLookupByLibrary.simpleMessage("Legal"),
      'ui_diagnostics': MessageLookupByLibrary.simpleMessage("Diagnostics"),
      'ui_saved_posts': MessageLookupByLibrary.simpleMessage("Saved posts"),
      'ui_liked_posts': MessageLookupByLibrary.simpleMessage("Liked posts"),
      'ui_nothing_saved_yet':
          MessageLookupByLibrary.simpleMessage("Nothing saved yet"),
      'ui_no_likes_yet': MessageLookupByLibrary.simpleMessage("No likes yet"),
      'ui_saved_posts_detail': MessageLookupByLibrary.simpleMessage(
          "Tap the archive icon on any post to keep it here. Only you can see what you save."),
      'ui_liked_posts_detail': MessageLookupByLibrary.simpleMessage(
          "Posts you like show up here, most recent first."),
      'ui_could_not_load_saved_posts': MessageLookupByLibrary.simpleMessage(
          "Could not load your saved posts"),
      'ui_could_not_load_liked_posts': MessageLookupByLibrary.simpleMessage(
          "Could not load your liked posts"),
      'feedTagDetail': (Object tab) =>
          'Nothing has been posted under #$tab yet.',
      'ui_feed_following_empty': MessageLookupByLibrary.simpleMessage(
          "Nothing from the people you follow"),
      'ui_feed_videos_empty':
          MessageLookupByLibrary.simpleMessage("No videos yet"),
      'ui_feed_empty': MessageLookupByLibrary.simpleMessage("Nothing here yet"),
      'ui_feed_following_detail': MessageLookupByLibrary.simpleMessage(
          "Follow a few accounts and their posts will show up here."),
      'ui_feed_videos_detail': MessageLookupByLibrary.simpleMessage(
          "Posts carrying a clip will show up here."),
      'ui_feed_for_you_detail': MessageLookupByLibrary.simpleMessage(
          "Posts will show up here as people write them."),
      'ui_could_not_load_feed':
          MessageLookupByLibrary.simpleMessage("Could not load your feed"),
      'ui_share_this_post':
          MessageLookupByLibrary.simpleMessage("Share this post"),
      'analytics_distinct_people_not_opens':
          MessageLookupByLibrary.simpleMessage(
              "Personas distintas, no aperturas"),
      'analytics_engagement':
          MessageLookupByLibrary.simpleMessage("Interacción"),
      'analytics_posted': MessageLookupByLibrary.simpleMessage("Publicada"),
      'analytics_viewers': MessageLookupByLibrary.simpleMessage("Espectadores"),
      'analytics_likes': MessageLookupByLibrary.simpleMessage("Me gusta"),
      'analytics_comments': MessageLookupByLibrary.simpleMessage("Comentarios"),
      'analytics_saves': MessageLookupByLibrary.simpleMessage("Guardados"),
      'analytics_no_viewers_yet':
          MessageLookupByLibrary.simpleMessage("Todavía no hay espectadores"),
      'analytics_viewers_per_day':
          MessageLookupByLibrary.simpleMessage("ESPECTADORES POR DÍA"),
      'analytics_nobody_opened_post': MessageLookupByLibrary.simpleMessage(
          "Nadie ha abierto esta publicación todavía."),
      'reply_who_can_reply':
          MessageLookupByLibrary.simpleMessage("¿Quién puede responder?"),
      'reply_anyone_can_see': MessageLookupByLibrary.simpleMessage(
          "Cualquiera puede verla, republicarla y citarla."),
      'reply_anyone':
          MessageLookupByLibrary.simpleMessage("Cualquiera puede interactuar"),
      'reply_anyone_detail': MessageLookupByLibrary.simpleMessage(
          "Cualquiera en Kyron puede responder a esta publicación."),
      'reply_followers':
          MessageLookupByLibrary.simpleMessage("Personas que te siguen"),
      'reply_followers_detail': MessageLookupByLibrary.simpleMessage(
          "Solo las personas que te siguen pueden responder a esta publicación."),
      'reply_mentioned':
          MessageLookupByLibrary.simpleMessage("Personas que mencionas"),
      'reply_mentioned_detail': MessageLookupByLibrary.simpleMessage(
          "Solo las personas que @mencionas en esta publicación pueden responder."),
      'reply_nobody':
          MessageLookupByLibrary.simpleMessage("Nadie puede responder"),
      'reply_nobody_detail': MessageLookupByLibrary.simpleMessage(
          "Las respuestas están desactivadas. Tú todavía puedes responder."),
      'interest_for_you': MessageLookupByLibrary.simpleMessage("Para ti"),
      'interest_following': MessageLookupByLibrary.simpleMessage("Siguiendo"),
      'interest_videos': MessageLookupByLibrary.simpleMessage("Vídeos"),
      'interest_your_tabs':
          MessageLookupByLibrary.simpleMessage("Tus pestañas"),
      'interest_drag_to_reorder':
          MessageLookupByLibrary.simpleMessage("Arrastra para reordenar"),
      'interest_add': MessageLookupByLibrary.simpleMessage("Añadir un interés"),
      'interest_trending_now':
          MessageLookupByLibrary.simpleMessage("Tendencias actuales"),
      'interest_five_tabs_limit': MessageLookupByLibrary.simpleMessage(
          "La barra admite como máximo cinco pestañas. Quita una para añadir otra."),
      'interest_hashtags_detail': MessageLookupByLibrary.simpleMessage(
          "Los hashtags aparecerán aquí cuando la gente empiece a usarlos."),
      'composer_placeholder_rattling':
          MessageLookupByLibrary.simpleMessage("¿Qué te ronda por la cabeza?"),
      'composer_placeholder_say': MessageLookupByLibrary.simpleMessage(
          "Di algo que solo tú puedas decir…"),
      'composer_placeholder_hot_take': MessageLookupByLibrary.simpleMessage(
          "Comparte una opinión fuerte (o una suave)"),
      'composer_placeholder_signal':
          MessageLookupByLibrary.simpleMessage("Esta es tu señal: envíala"),
      'composer_placeholder_think': MessageLookupByLibrary.simpleMessage(
          "Escribe, habla o piensa en voz alta"),
      'profile_tap_to_change':
          MessageLookupByLibrary.simpleMessage("Toca para cambiar"),
      'profile_display_name':
          MessageLookupByLibrary.simpleMessage("Nombre visible"),
      'profile_bio': MessageLookupByLibrary.simpleMessage("Biografía"),
      'profile_location': MessageLookupByLibrary.simpleMessage("Ubicación"),
      'profile_website': MessageLookupByLibrary.simpleMessage("Sitio web"),
      'translation_description': MessageLookupByLibrary.simpleMessage(
          "Las palabras propias de Kyron todavía se están traduciendo, así que la mayoría de las pantallas siguen en inglés. Por ahora se traducen las partes de la interfaz que dibuja Flutter, las fechas y los números, y la dirección de diseño para idiomas de derecha a izquierda."),
      'theme_system_detail': MessageLookupByLibrary.simpleMessage(
          "Usar el modo claro u oscuro del teléfono"),
      'theme_light_detail':
          MessageLookupByLibrary.simpleMessage("Siempre claro"),
      'theme_dark_detail':
          MessageLookupByLibrary.simpleMessage("Siempre oscuro"),
      'theme_dim_detail': MessageLookupByLibrary.simpleMessage(
          "Un modo oscuro más suave, azul grisáceo en lugar de negro"),
      'theme_system': MessageLookupByLibrary.simpleMessage("Sistema"),
      'theme_light': MessageLookupByLibrary.simpleMessage("Claro"),
      'theme_dark': MessageLookupByLibrary.simpleMessage("Oscuro"),
      'theme_dim': MessageLookupByLibrary.simpleMessage("Atenuado"),
    };

final messageLookup = MessageLookup();
