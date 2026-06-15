from flask import Flask, jsonify
from flask_cors import CORS
from init_db import get_db_connection

app = Flask(__name__)
CORS(app)

# ====================================
# MÓDULO 1 (PAINEL GERAL)
# ====================================
@app.route('/api/equipes', methods=['GET'])
def listar_equipes():
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM vw_visao_geral_equipes;")
        linhas = cursor.fetchall()

        equipes_dict = {}
        for linha in linhas:
            codigo_equipe, nome_aluno, papel_aluno, nome_do_projeto, codigo_projeto = linha

            if codigo_equipe not in equipes_dict:
                equipes_dict[codigo_equipe] = {
                    "codigo_equipe": codigo_equipe,
                    "codigo_projeto": codigo_projeto,
                    "nome_do_projeto": nome_do_projeto,
                    "membros": []
                }

            equipes_dict[codigo_equipe]["membros"].append({
                "nome": nome_aluno,
                "papel": papel_aluno
            })

        lista_final_equipes = list(equipes_dict.values())
        return jsonify(lista_final_equipes), 200
    
    except Exception as e:
        return jsonify({ "erro": f"Erro ao buscar equipes: {str(e)}" }), 500
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

@app.route('/api/equipes/<int:id_equipe>/projeto/<int:projeto_id>/github', methods=['GET'])
def repositorio_equipe():
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT obter_ultimo_github(%s, %s);")
        resultado = cursor.fetchone()
        
        return jsonify({ "link_github": resultado }), 200
    
    except Exception as e:
        return jsonify({ "erro": f"Erro ao buscar link do repositório: {str(e)}" }), 500
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

# ====================================
# MÓDULO 2 (ACOMPANHAMENTO DE SPRINTS)
# ====================================
@app.route('/api/equipes/<int:equipe_id>/sprints', methods=['GET'])
def listar_sprints_e_entregas(equipe_id):
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute(f"""
            SELECT * FROM vw_acompanhamento_sprints 
            WHERE codigo_equipe = {equipe_id};
        """)
        linhas = cursor.fetchall()

        sprints = {}
        for linha in linhas:
            codigo_equipe, nome_projeto, numero_sprint, prazo_sprint, titulo_entrega, link_repositorio, data_submissao = linha

            if numero_sprint not in sprints:
                sprints[numero_sprint] = {
                    "codigo_equipe": codigo_equipe,
                    "nome_projeto": nome_projeto,
                    "numero_sprint": numero_sprint,
                    "prazo_sprint": prazo_sprint,
                    "entregas": []
                }

            sprints[numero_sprint]["entregas"].append({
                "titulo_entrega": titulo_entrega,
                "link_repositorio": link_repositorio,
                "data_submissao": data_submissao
            })
            
        lista_final_sprints = list(sprints.values())
        return jsonify(lista_final_sprints), 200
    
    except Exception as e:
        return jsonify({ "erro": f"Erro ao buscar informações sobre as sprints: {str(e)}" }), 500
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=5000)
