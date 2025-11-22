//
//  StoryData.swift
//  Proyecto2
//
//  Created by Alumno on 19/11/25.
//
import Foundation

struct StoryPage: Identifiable {
    let id = UUID()
    let imageName: String
    let text: String
}

struct HistoriaData: Identifiable {
    let id = UUID()
    let titulo: String
    let portada: String
    let paginas: [StoryPage]
}

class StoryRepository {
    static let historias: [HistoriaData] = [
        HistoriaData(
            titulo: "Un día normal",
            portada: "niña",
            paginas: [
                                StoryPage(
                                    imageName: "Spag1",
                                    text: "Sofi era una niña alegre que amaba dibujar y jugar con su perro Max. Ella tenía alergia alimentaria, pero sabía cuidarse muy bien."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag2",
                                    text: "Su mamá siempre le decía: 'Sofi, si algún día tienes una reacción fuerte llamada anafilaxia, recuerda el superplan'."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag3",
                                    text: "Un día, Sofi fue a una fiesta de cumpleaños. Todo se veía delicioso y había muchos postres. Ella preguntó cuáles podía comer..."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag4",
                                    text: "...pero sin querer probó uno que tenía el alimento al que era alérgica."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag5",
                                    text: "Poco después comenzó a sentir la garganta apretada, la piel caliente con ronchitas, respiración pesada y un mareo raro."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag6",
                                    text: "Sofi recordó el Superplan de Emergencia. Pensó: 'Estos son los síntomas que me explicaron… Creo que es una anafilaxia'."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag7",
                                    text: "Sabía que debía actuar rápido. Tomó su autoinyector de adrenalina, lo colocó en su muslo y presionó hasta sentir el clic."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag8",
                                    text: "Le dijo a la mamá de la cumpleañera: 'Por favor, llamen al servicio de emergencias. Estoy teniendo una reacción fuerte'."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag9",
                                    text: "Mientras esperaban, Sofi se acostó con cuidado. 'No debo caminar ni moverme mucho', recordó. Un amigo se quedó a su lado."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag10",
                                    text: "Pasaron unos minutos y no se sentía mejor. La mamá de la cumpleañera le aplicó el segundo autoinyector, tal como decía el plan."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag11",
                                    text: "Cuando llegó la ambulancia, Sofi subió acompañada. Sabía que siempre debía ser revisada por médicos, aunque ya se sintiera mejor."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag12",
                                    text: "En el hospital, los médicos la atendieron rápidamente y todo salió bien."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag13",
                                    text: "Mientras descansaba, pensó: 'Hoy usé mi plan y funcionó. No fue fácil, pero lo logré'."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag14",
                                    text: "Al día siguiente, dibujó un cartel con todos los pasos de emergencia. 'Así nadie se asusta y todos saben qué hacer', dijo sonriendo."
                                ),
                                
                                StoryPage(
                                    imageName: "Spag15",
                                    text: "Desde entonces, Sofi siguió yendo a fiestas y jugando, segura de que conocía su cuerpo y sabía cómo cuidarse."
                                )
                            ]
        ),
        
        HistoriaData(
            titulo: "Luli la tortuga",
            portada: "luli",
            paginas: [
                StoryPage(
                    imageName: "Tpag1",
                    text: "Había una vez una tortuga llamada Luli, que amaba bailar, leer libros y comer galletas de chispas de chocolate."
                ),
                
                StoryPage(
                    imageName: "Tpag2",
                    text: "Un día, mientras estaba en el recreo, comió una galleta nueva que trajo un amigo… con mucha curiosidad."
                ),
                
                StoryPage(
                    imageName: "Tpag3",
                    text: "¡Pum! De repente empezó a sentirse rara: le picaba la boca, la piel se le puso roja y sintió que su corazón latía más rápido."
                ),
                
                StoryPage(
                    imageName: "Tpag4",
                    text: "La maestra la llevó rápido con la enfermera para que la revisaran de inmediato."
                ),
                
                StoryPage(
                    imageName: "Tpag5",
                    text: "El doctor le explicó: 'Luli, tienes una alergia alimentaria'. Tenían que identificar qué alimento le causó daño."
                ),
            
                StoryPage(
                    imageName: "Tpag6",
                    text: "Luli dijo: '¡Entonces seré un detective de comida!'. Aprendió a buscar en etiquetas: 'Contiene nueces' o 'trazas'."
                ),
                
                StoryPage(
                    imageName: "Tpag7",
                    text: "Luli pensó: 'Si dice eso… ¡puede hacerme daño!'. Así evitaba accidentes como un verdadero héroe experto."
                ),
                
                StoryPage(
                    imageName: "Tpag8",
                    text: "Aprendió a avisar a todos: familia, escuela, amigos y a la señora del comedor. Ahora todos sabían cómo cuidarla."
                ),
                
                StoryPage(
                    imageName: "Tpag9",
                    text: "Aprendió los síntomas: picazón, ronchitas, hinchazón, dificultad para respirar o dolor de estómago."
                ),
                StoryPage(
                    imageName: "Tpag10",
                    text: "Aprendió que al primer indicio de un sintoma lo mejor es avisar a un adulto responsable."
                ),
                
                StoryPage(
                    imageName: "Tpag11",
                    text: "Luli dijo: '¡Ahora conozco mis poderes!'. Vivió feliz sabiendo que tener una alergia no la hacía menos fuerte, solo más valiente."
                )
            ]
        ),
        
        HistoriaData(
            titulo: "Copito el conejo",
            portada: "Copito",
            paginas: [
                            StoryPage(
                                imageName: "Cpag1",
                                text: "Había una vez un conejito pequeño llamado Copito, que vivía feliz en su madriguera."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag2",
                                text: "Vivía con sus papás y sus hermanitos: Nubecita, Brinco y Orejitas. ¡Le encantaba la cocina!"
                            ),
                            
                            StoryPage(
                                imageName: "Cpag3",
                                text: "Un día, mamá preparó un pastel de zanahoria. Todos aplaudieron emocionados."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag4",
                                text: "Copito probó el pastel y sintió un leve cosquilleo en la boca. 'Seguro es mi imaginación', pensó, y siguió comiendo."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag5",
                                text: "Al día siguiente, probó sopa de zanahoria. Su boca volvió a picarle y también su garganta. Se preocupó, pero no dijo nada."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag6",
                                text: "Unos días después, comió zanahorias asadas. Esta vez fue diferente: su garganta se cerró y le costaba respirar."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag7",
                                text: "Su corazón latía rápido. '¡Mamá… papá… no puedo… respirar!', logró decir muy asustado."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag8",
                                text: "Su papá lo tomó en brazos y corrieron lo más rápido posible al Hospital del Prado."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag9",
                                text: "Los doctores lo vieron muy mal. '¡Rápido, es una anafilaxia!', gritó una doctora."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag10",
                                text: "Después del tratamiento, Copito se sintió mejor. Mamá le acariciaba la oreja: 'Todo está bien, pequeño, ya estás a salvo'."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag11",
                                text: "El doctor Zorro explicó que fue una alergia a la zanahoria y les enseñó los síntomas: picazón, hinchazón, tos o dificultad para respirar."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag12",
                                text: "Copito bajó la mirada: 'Yo sí sentía cosas raras… pero pensé que no era importante'. El doctor le dijo que siempre debía escuchar a su cuerpo."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag13",
                                text: "De regreso, Copito veía a su familia comer zanahorias y se sentía triste. 'Extraño comer como todos… ¿Por qué yo?', pensó."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag14",
                                text: "En el hospital, conoció a un ratón, una ardilla y un mapache. Todos tenían alergias diferentes: fresas, nueces, polen."
                            ),
                            StoryPage(
                                imageName: "Cpag15",
                                text: "Copito se sorprendió: '¿No soy el único?'. Ellos le contaron que aprendieron a cuidarse y eran muy felices."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag16",
                                text: "Mamá encontró nuevas recetas: pastel de manzana y galletas de avena. Copito probó y sus ojos brillaron. ¡Estaba delicioso!"
                            ),
                            
                            StoryPage(
                                imageName: "Cpag17",
                                text: "Desde entonces, Copito avisa si siente algo raro, revisa ingredientes y lleva sus medicinas. Se siente fuerte y seguro."
                            ),
                            
                            StoryPage(
                                imageName: "Cpag18",
                                text: "Copito entendió que tener alergia no lo hace diferente, ¡lo hace valiente! Vivió feliz rodeado de su familia."
                            )
                        ]
        ),
        HistoriaData(
            titulo: "Piko no puede comer flores",
            portada: "Ppag0",
            paginas: [
                StoryPage(
                    imageName: "Ppag1",
                    text: "Piko no puede comer flores."
                ),
                StoryPage(
                    imageName: "Ppag2",
                    text: "Cuando pico era pequeño se sentía mal al comer ensaladas."
                ),
                
                StoryPage(
                    imageName: "Ppag3",
                    text: "Piko fue al doctor de alergias y él le dijo que el problema eran las flores."
                ),
                
                StoryPage(
                    imageName: "Ppag4",
                    text: "— ¡Eres alérgico a las flores! —  le dijo el doctor — Si comes flores vas a enfermar! — añadió"
                ),
                
                StoryPage(
                    imageName: "Ppag5",
                    text: "— ¡No quiero sentirme mal! — dijo Piko muy asustado — ¡Calma!, ¡solo tienes que seguir mis consejos! - dijo el doctor"
                ),
                
                StoryPage(
                    imageName: "Ppag6",
                    text: "¡Nunca metas flores en tu boca!"
                ),
            
                StoryPage(
                    imageName: "Ppag7",
                    text: "Cuando prepares tu comida, ¡no añadas flores!"
                ),
                
                StoryPage(
                    imageName: "Ppag8",
                    text: "Si alguien más te da tu comida, pregunta, ¿Esto tiene flores?"
                ),
                
                StoryPage(
                    imageName: "Ppag9",
                    text: "Habla con tu familia y amigos y diles que no puedes comer flores."
                ),
                
                StoryPage(
                    imageName: "Ppag10",
                    text: "Aprendió los síntomas: picazón, ronchitas, hinchazón, dificultad para respirar o dolor de estómago. ¡Asegúrate de que tus personas cercanas conozcan cuales son los síntomas de tu alergia! También ayúdales a identificar cuando tienes una emergencia y cómo colocar adrenalina."
                ),
                StoryPage(
                    imageName: "Ppag11",
                    text: "— ¡Gracias doctor! — dijo Piko — Ahora se que debo hacer "
                ),
                
            ]
        ),
        HistoriaData(
            titulo: "Jugando en el parque",
            portada: "Apag0",
            paginas: [
                StoryPage(
                    imageName: "Apag1",
                    text: "Un día, Ann estaba en un picnic en el parque con su amigo Ju. "
                ),
                StoryPage(
                    imageName: "Apag2",
                    text: "Los dos estaban comiendo tranquilamente, cuando de repente, ¡Ju comenzó a marearse y se desmayó!"
                ),
                
                StoryPage(
                    imageName: "Apag3",
                    text: "Ann no entendía que sucedía, hasta que vió la galleta que Ju estaba comiendo, ¡las galletas tenían nueces y Ju es alérgico!"
                ),
                
                StoryPage(
                    imageName: "Apag4",
                    text: "Por suerte, Ann recordó que Ju tenía adrenalina en su mochila, así que rápidamente la sacó y se la colocó en el muslo."
                ),
                
                StoryPage(
                    imageName: "Apag5",
                    text: "Ju ya había explicado a sus compañeros de clase y a su maestra que era alérgico a las nueces"
                ),
                
                StoryPage(
                    imageName: "Apag6",
                    text: "Cómo Ann siempre jugaba con Ju, ella decidió aprender a colocar adrenalina, en caso de que sucediera alguna emergencia."
                ),
            
                StoryPage(
                    imageName: "Apag7",
                    text: "Ann llamó a una ambulancia y llevaron a Ju al hospital."
                ),
                
                StoryPage(
                    imageName: "Apag8",
                    text: "En el hospital, el doctor de las alergias visitó a Ju y lo revisó, ¡afortunadamente Ju se recuperó!"
                ),
                
                StoryPage(
                    imageName: "Apag9",
                    text: "Ann se sintió muy afortunada de que pudo ayudar a su amigo cuando él la necesitaba."
                ),
                
                StoryPage(
                    imageName: "Apag10",
                    text: "Desde ese día Ann verifica que las galletas que compra no tengan nueces."
                ),
                
            ]
        )
        
    ]
}
