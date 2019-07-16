import 'package:flutter_test/flutter_test.dart';
import 'package:sgf_parser/properties/boardSize.dart';
import 'package:sgf_parser/properties/fileFormat.dart';
import 'package:sgf_parser/game/gameAttributes.dart';
import 'package:sgf_parser/properties/gameType.dart';
import 'package:sgf_parser/sgfParser.dart';

void main() {
  test('Can parse full game', () {
    const sgfString =
        '(;FF[4]GM[1]SZ[19]AP[]US[]EV[74th Honinbo challenger decision match]PC[]PB[Shibano Toramaru]BR[7d]PW[Kono Rin]WR[9d]KM[6.5]RE[W+1.5]DT[2019-04-10]TM[0];B[pd];W[dp];B[pq];W[dc];B[ce];W[cg];B[cq];W[cp];B[dq];W[fq];B[fr];W[ep];B[gq];W[gp];B[gr];W[df];B[hp];W[ho];B[ip];W[nc];B[oc];W[nd];B[pf];W[jd];B[po];W[gn];B[io];W[qh];B[hm];W[pl];B[cc];W[cb];B[db];W[eb];B[dd];W[da];B[ec];W[fc];B[db];W[qe];B[pe];W[dc];B[ed];W[rf];B[qd];W[bc];B[db];W[rd];B[rc];W[dc];B[pk];W[qk];B[qj];W[pj];B[ok];W[rj];B[ql];W[rk];B[db];W[pr];B[oq];W[dc];B[qm];W[cd];B[oj];W[pi];B[oi];W[oh];B[nh];W[qq];B[or];W[fk];B[bd];W[cc];B[dh];W[ch];B[dj];W[dl];B[gh];W[fi];B[fh];W[eh];B[eg];W[ei];B[ef];W[di];B[hj];W[hl];B[gl];W[gi];B[hi];W[gk];B[il];W[hk];B[ik];W[hh];B[gf];W[hg];B[ie];W[gg];B[je];W[fg];B[kd];W[og];B[ne];W[me];B[nf];W[kc];B[jc];W[ld];B[id];W[kb];B[kg];W[lf];B[jh];W[ng];B[mh];W[rn];B[qp];W[ii];B[ji];W[qn];B[pm];W[rp];B[rq];W[rm];B[rg];W[rb];B[qg];W[qc];B[qb];W[sc];B[pb];W[ra];B[mg];W[pn];B[on];W[qo];B[qr];W[rh];B[nb];W[mb];B[ma];W[la];B[na];W[om];B[ol];W[oo];B[nm];W[nn];B[mc];W[om];B[lb];W[hc];B[gd];W[on];B[bq];W[bp];B[gc];W[gb];B[fd];W[ib];B[fb];W[fa];B[jb];W[de];B[mm];W[eq];B[er];W[hn];B[in];W[mp];B[gm];W[fn];B[ap];W[ao];B[aq];W[bo];B[lq];W[mq];B[lo];W[lp];B[mo];W[np];B[el];W[fl];B[fm];W[em];B[im];W[en];B[kq];W[kp];B[mr];W[ja];B[ka];W[lr];B[kr];W[la];B[sg];W[ic];B[se];W[jd];B[jc];W[lc];B[ih];W[rl];B[pl];W[jp];B[jq];W[nr];B[ls];W[pp];B[qq];W[jn];B[kn];W[jo];B[jm];W[nq];B[mb];W[md];B[dg];W[cf];B[jd];W[ff];B[ee];W[jb];B[sp];W[so];B[ro];W[mn];B[ln];W[rp];B[sh];W[si];B[ro];W[gj];B[ij];W[rp];B[sq];W[if];B[kf];W[ge];B[hd];W[ns];B[ro];W[lm];B[km];W[rp];B[op];W[no];B[ro];W[nl];B[ll];W[rp];B[ha];W[ga];B[ro];W[dr];B[cr];W[rp];B[lg];W[pg];B[re];W[ms];B[lr];W[os];B[ps];W[rs];B[rr];W[hf];B[ro];W[qs];B[ss];W[rp];B[of];W[ph];B[ro];W[iq];B[ir];W[rp];B[he];W[fe];B[ro];W[jr];B[js];W[rp];B[od];W[ro];B[fc];W[ka];B[ko];W[po])';

    var parser = SGFParser(sgfString);
    var game = parser.parse();
    GameAttributes attributes = game.attributes;

    FileFormat expectedFormat = FileFormat.FF4;
    DateTime expectedDate = DateTime(2019, 4, 10);
    GameType expectedGameType = GameType.Go;
    BoardSize expectedBoardSize = BoardSize.square(19);
    String event = '74th Honinbo challenger decision match';

    expect(attributes.fileFormat, equals(expectedFormat));
    expect(attributes.date, equals(expectedDate));
    expect(attributes.gameType, equals(expectedGameType));
    expect(attributes.boardSize.rows, equals(expectedBoardSize.rows));
    expect(attributes.boardSize.columns, equals(expectedBoardSize.columns));
    expect(attributes.event, equals(event));
  });
}
