include("MapEnGraphe.jl")
include("Affichage.jl")
using DataStructures

function algoBFS(fname, vD, vA)

    temps = @elapsed begin
        allocation = @allocated begin
            M = lireMapNonPondere("../dat/$fname")
    
            distance = 0 

            rows = size(M, 1)   # nombre de lignes
            cols = size(M, 2)   # nombre de colonnes

            # Les 4 voisins possibles : haut, droite, bas, gauche
            directions = [(-1,0), (0,1), (1,0), (0,-1)]

            visites      = falses(rows, cols)          # Matrice de booléens
            predecesseur = fill((0,0), rows, cols)   # pour reconstruire le chemin

            file = Vector{typeof(vD)}() # Création d'une file du même type que vD
            push!(file,vD)
            visites[vD[1], vD[2]] = true

            nb_etats = 0 # nombre d'etats visitée
            cheminValide = false

            while !isempty(file)
                pos = popfirst!(file)   # position actuelle (ligne, colonne)

                nb_etats += 1

                if pos == vA
                    cheminValide = true
                    break
                end

                for (dl, dc) in directions
                    nl = pos[1] + dl   # nouvelle ligne
                    nc = pos[2] + dc   # nouvelle colonne

                    # Vérifications :
                    if 1 <= nl <= rows && # on reste dans la Map
                        1 <= nc <= cols && # on reste dans la Map
                        M[nl, nc] != 0 && # la case n'est pas un mur
                        !visites[nl, nc]

                        visites[nl, nc] = true
                        predecesseur[nl, nc] = pos      # on vient de pos
                        push!(file, (nl, nc))
                    end
                end
            end

            # Reconstruction du chemin
            chemin = []
            if cheminValide
                etape = vA
                while etape !== (0,0)
                    push!(chemin, etape)
                    etape = predecesseur[etape[1], etape[2]]
                end 
                chemin = reverse(chemin)
            end

            for (i,j) in chemin 
                distance += M[i,j] # distance entre D et A
            end
        end
    end

    return afficherResultat(distance, nb_etats, chemin, temps, allocation)
end 

