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
    };

final messageLookup = MessageLookup();
